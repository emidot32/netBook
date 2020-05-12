import {Component, OnInit, OnDestroy} from '@angular/core';

import * as Stomp from 'stompjs';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';
import {User, Message, Chat} from '../_models/interface';
import {AuthenticationService} from '../_services/authentication.service';
import {ChatService} from '../_services/chat.service';
import {UserService} from '../_services/user.service';

@Component({
  selector: 'app-content-chat',
  templateUrl: './content-chat.component.html',
  styleUrls: ['./content-chat.component.css']
})
export class ContentChatComponent implements OnInit, OnDestroy {
  private stompClient;
  public msg = '';
  public messages: Message[] = [];
  public chats: Chat[] = [];
  public username = '';
  public activeChat: number;
  public friends: User[] = [];
  public chatName = '';
  public editedChatName = '';
  public chatMembers: User[] = [];
  // friendsWhoAbleToAddToChat
  public friendsWhoAbleToAdd: User[] = [];
  public editChatTab = 0;
  public activeChatAvatar = '';
  private fileToUpload: File = null;
  public namePattern = '^\\s*[a-zA-Z0-9а-яёАЯЁ_]+(?:\\s*[a-zA-Z0-9а-яёАЯЁ_]+)*\\s*$';
  private headers = {
    Authorization: this.authenticationService.currentUserValue.token};

  constructor(private toastr: ToastrService,
              private chatService: ChatService,
              private userService: UserService,
              private authenticationService: AuthenticationService) {  }

  ngOnInit() {
    window.scroll(0, 0);
    this.authenticationService.refreshToken();
    this.username = this.authenticationService.currentUserValue.username;
    this.headers = {
      Authorization: this.authenticationService.currentUserValue.token };
    this.getChats();
    this.userService.getFriends(this.username, 500, 0)
      .subscribe(
        (data: User[]) => {
          this.friends = data;
        });
  }

  ngOnDestroy() {
    if (this.stompClient) {
      this.disconnect();
    }
  }

  getChats() {
    this.chatService.getChats(this.username)
      .subscribe(
        (data: Chat[]) => {
          this.chats = data;
        });
  }

  clearCheckedFriendsAndName() {
    this.chatName = '';
    for (const friend of this.friends) {
      friend.checked = false;
    }
  }
  // for add frined into new chat
  onClickCheckBox(friend: User) {
    friend.checked = !friend.checked;
  }

  getMessagesHistory(chatId: number) {
    this.chatService.getMessagesHistory(chatId)
      .subscribe(
        (data: Message[]) => {
          this.messages = data;
        });
  }

  createNewChat() {
    const addingFriends: string[] = [];
    for (const friend of this.friends) {
      if (friend.checked) {
        addingFriends.push(friend.username);
      }

    }
    addingFriends.push(this.username);
    this.chatService.createNewChat(this.userService.escaping(this.chatName), addingFriends)
      .subscribe(() => {
        this.getChats();
        this.toastr.success(`Chat ${this.chatName} successfully created`);
      },
        error => {
          this.toastr.info(error);
        });
  }

  isExistPerson(persons: User[], soughtPerson: User) {
    for (const person of persons) {
      if (person.username === soughtPerson.username) {
        return true;
      }
    }
    soughtPerson.checked = false;
    return false;
  }

  getChatMembers(chatId: number) {
    this.chatService.getChatMembers(chatId)
      .subscribe(
        (data: User[]) => {
          this.chatMembers = data;
          this.friendsWhoAbleToAdd = this.friends.filter(
            x => !this.isExistPerson(this.chatMembers, x));
        },
        error => {
          this.toastr.info(error);
        });
  }

  editChat() {
    const removedMembers: string[] = [];
    for (const friend of this.chatMembers) {
      if (friend.checked) {
        removedMembers.push(friend.username);
      }
    }

    const addedMembers: string[] = [];
    for (const friend of this.friendsWhoAbleToAdd) {
      if (friend.checked) {
        addedMembers.push(friend.username);
      }
    }
    if (removedMembers.length > 0) {
      if (window.confirm(`This will completely remove members from ${this.chatName}.`)) {
        this.commitEditChat(addedMembers, removedMembers);
      }
    } else { this.commitEditChat(addedMembers, removedMembers); }
  }
  commitEditChat(addedMembers: string[], removedMembers: string[]) {
    this.chatService.updateChat(this.activeChat, this.editedChatName,
     addedMembers, removedMembers, this.fileToUpload, this.getChatAvatar())
      .subscribe(
          () => {
            this.toastr.success(`Chat successfully updated`);
            this.getChats();
            this.activeChat = null;
          },
          error => {
            this.toastr.info(error);
          });
  }

  handleFileInput(files: FileList) {
    if (files.item(0).size / 1024 / 1024 > 1) {
      this.toastr.info(`Picture size must be < 1 MB`);
      return;
    } else if (files.item(0).type.match(/image\/*/) == null) {
      this.toastr.info(`Its not an image, please select image`);
      return;
    }
    this.fileToUpload = files.item(0);
    const reader = new FileReader();
    reader.readAsDataURL(this.fileToUpload);
    reader.onload = () => {
      this.activeChatAvatar = reader.result.toString();
    };
  }

  prepareEditMenu() {
    this.editedChatName = this.chats.find(x => x.chatId === this.activeChat).chatName;
    this.getChatMembers(this.activeChat);
    this.activeChatAvatar = this.getPhoto(this.getChatAvatar());
    this.fileToUpload = null;
    this.editChatTab = 0;
  }
  getAvatarPathByLogin(login: string) {
    return this.getPhoto(this.chatMembers.find(x => x.username === login).avatarFilePath);
  }
  getChatAvatar() {
    return this.chats.find(x => x.chatId === this.activeChat).chatAvatar;
  }
  /*----websocket service block--------*/
  // onClick Chat select
  onClick(chatId: number) {
    if (this.stompClient) { this.disconnect(); }
    this.activeChat = chatId;
    this.messages = [];
    this.chatName = this.chats.find(x => x.chatId === this.activeChat).chatName;
    this.getChatMembers(this.activeChat);
    this.initializeWebSocketConnection();
    this.getMessagesHistory(chatId);
  }
  sendMessage() {
    if (this.msg.length < 1) { return; }
    const message: Message = { message: this.msg,
      fromName: this.username, toId: this.activeChat, dateTimeSend: null };
    this.stompClient.send(`/socket-subscriber/send/message/${this.activeChat}`,
      this.headers, JSON.stringify(message));
    this.msg = '';
  }

  initializeWebSocketConnection() {
    const socket = new WebSocket(`${environment.webSocket}`);
    this.stompClient = Stomp.over(socket);
    const that = this;
    this.stompClient.connect({
      Authorization: this.authenticationService.currentUserValue.token }, frame => {
      that.openSocket();
    });
  }

  openSocket() {
    this.stompClient.subscribe(`/socket-publisher/${this.activeChat}`, (message) => {
      this.handleResult(message);
    }, this.headers);
  }

  handleResult(message) {
    if (message.body) {
      const messageResult: Message = JSON.parse(message.body);
      this.messages.push(messageResult);
    }
  }

  disconnect() {
    this.stompClient.ws.close();
  }
  /*------------------*/
  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }
}
