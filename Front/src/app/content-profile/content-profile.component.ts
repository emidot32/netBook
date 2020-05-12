import {Component, OnDestroy, OnInit} from '@angular/core';
import {User, Achievement, ShortBookDescription} from '../_models/interface';
import {UserService} from '../_services/user.service';
import {AlertService} from '../_services/alert.service';
import { Router, ActivatedRoute } from '@angular/router';
import {BehaviorSubject, Observable, Subscribable, Subscription} from 'rxjs';
import { environment } from '../../environments/environment';
import {AuthenticationService} from '../_services/authentication.service';
import { ToastrService } from 'ngx-toastr';
import {BookService} from '../_services/book.service';

@Component({
  selector: 'app-content-profile',
  templateUrl: './content-profile.component.html',
  styleUrls: ['./content-profile.component.css']
})
export class ContentProfileComponent implements OnInit, OnDestroy {

  public user: User = {} as User;
  public friends: User[] = [];
  public favouriteBooks: ShortBookDescription[] = [];
  public readingBooks: ShortBookDescription[] = [];
  public readBooks: ShortBookDescription[] = [];
  public achievements: Achievement[] = [];
  public isFriend = -1;
  public canEditable = false;
  private login: string;
  private paramsSubscribe: Subscription;

  constructor(private userService: UserService,
              private activatedRoute: ActivatedRoute,
              private router: Router,
              private authenticationService: AuthenticationService,
              private alertService: AlertService,
              private bookService: BookService,
              private toastr: ToastrService) {
  }

  ngOnInit() {
    this.paramsSubscribe = this.activatedRoute.params.subscribe(params => {
      this.login = params.login;
      this.loadUserProfile();
      window.scroll(0, 0);
    });
  }
  ngOnDestroy() {
    this.paramsSubscribe.unsubscribe();
  }

  loadUserProfile() {
    this.authenticationService.refreshToken();
    this.userService.getUser(this.login)
      .subscribe(
        (data: User) => {
          this.user = data;
        },
        error => {
          this.toastr.info(error);
          this.router.navigate(['/homeath/announcement']);
        });

    this.canEdit();

    this.userService.getAchievements(this.login)
      .subscribe(
        (data: Achievement[]) => {
          this.achievements = data;
        });

    this.userService.getFriends(this.login, 4, 0)
      .subscribe(
        (data: User[]) => {
          this.friends = data;
        });

    this.userService.getFavouriteBooks(this.login, '', 3, 0)
      .subscribe(
        (data: ShortBookDescription[]) => {
          this.favouriteBooks = data;
        });

    this.userService.getReadingBooks(this.login, '', 3, 0)
      .subscribe(
        (data: ShortBookDescription[]) => {
          this.readingBooks = data;
        });

    this.userService.getReadBooks(this.login, '', 3, 0)
      .subscribe(
        (data: ShortBookDescription[]) => {
          this.readBooks = data;
        });
  }
  goEdit() {
    this.router.navigate([`/homeath/profile/${this.login}/edit`]);
  }
  addFriend() {
    this.userService.addFriend(this.authenticationService.currentUserValue.username, this.login)
      .subscribe(
        () => {
          this.toastr.success(`${this.login} was added to friends`);
          this.isFriendFunction();
        },
        error => {
          this.toastr.error(error);
        });
  }
  isFriendFunction() {
    this.userService.isFriend(this.authenticationService.currentUserValue.username, this.login)
      .subscribe(
        (data: number) => {
          this.isFriend = data;
        });
  }
  deleteFriend() {
    this.userService.deleteFriend(this.authenticationService.currentUserValue.username, this.login)
      .subscribe(
        () => {
          this.toastr.success(`${this.login} was removed from friends`);
          this.isFriendFunction();
        },
        error => {
          this.toastr.info(error);
        });

  }

  canEdit() {
    this.userService.isEditable(this.login)
    .subscribe(
      data => {
        if (!data && this.authenticationService.currentUserValue.role !== 4) {
          this.isFriend = -2;
        } else { this.isFriendFunction(); }

        this.canEditable = data;
        });
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

  navigateToAuthor(author: string) {
    this.router.navigate(['/homeath/search']);
    this.bookService.changeTitle(author);
  }
}
