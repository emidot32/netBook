import { Injectable } from '@angular/core';

import {HttpClient, HttpParams, HttpResponse} from '@angular/common/http';

import {User, Message, Chat} from '../_models/interface';
import {AuthenticationService} from '../_services/authentication.service';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  constructor(private http: HttpClient) { }

  getChats(login: string) {
    return this.http.get<Chat[]>(`${environment.apiUrl}/chat/${login}/chats`);
  }

  getMessagesHistory(chatId: number) {
    return this.http.get<Message[]>(`${environment.apiUrl}/chat/${chatId}`);
  }

  createNewChat(chatName: string, members: string[]) {
    return this.http.post<void>(`${environment.apiUrl}/chat/create/${chatName}`, members);
  }
  getChatMembers(chatId: number) {
    return this.http.get<User[]>(`${environment.apiUrl}/chat/${chatId}/members`);
  }

  updateChat(chatId: number, chatName: string, addedMembers: string[], removedMembers: string[], file: File,
             oldChatAvatar) {
    const formData: FormData = new FormData();
    formData.append('file', file);
    return this.http.put<void>(`${environment.apiUrl}/chat/${chatId}/update/${chatName}?addedMembers=${addedMembers}` +
      `&removedMembers=${removedMembers}&oldChatAvatar=${oldChatAvatar}`, formData);
  }
}




