import { Component, OnInit } from '@angular/core';
import {User, Achievement, SearchIn} from '../_models/interface';
import {UserService} from '../_services/user.service';
import {AlertService} from '../_services/alert.service';
import { Router, ActivatedRoute } from '@angular/router';
import {FormControl, FormGroup} from '@angular/forms';
import {AuthenticationService} from '../_services/authentication.service';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-content-friends',
  templateUrl: './content-friends.component.html',
  styleUrls: ['./content-friends.component.css']
})
export class ContentFriendsComponent implements OnInit {

  public peoples: User[] = [];
  private login: string;
  private sought = '';
  public page = 1;
  private where = SearchIn.FRIENDS;
  public collectionSize = 9;
  public endOfFriends = false;
  public _SearchIn = SearchIn;

  constructor(private userService: UserService,
              private activatedRoute: ActivatedRoute,
              private router: Router,
              private authenticationService: AuthenticationService,
              private alertService: AlertService,
              private toastr: ToastrService) {}

  ngOnInit() {
    window.scroll(0, 0);
    this.login = this.activatedRoute.snapshot.params.login;
    this.authenticationService.refreshToken();
    this.getPersons();
  }
  onSearchChange(searchValue: string) {
    this.page = 1;
    this.sought = this.userService.escaping(searchValue);
    this.peoples = [];
    this.endOfFriends = false;
    this.getPersonsNewSought();
  }
  onWhereChange(whereValue: SearchIn) {
    this.page = 1;
    this.where = whereValue;
    this.peoples = [];
    this.endOfFriends = false;
    this.getPersons();
  }
  onPageChanged() {
    this.page++;
    this.getPersons();
  }
  // call when scrolling
  getPersons() {
    this.userService.getPersons(this.login, this.sought, this.where, this.collectionSize, this.page - 1)
      .subscribe(
        (data: User[]) => {
          if (data.length < this.collectionSize) { this.endOfFriends = true; }
          this.peoples = this.peoples.concat(data);
        },
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
  }
  // call when changing sought
  getPersonsNewSought() {
    this.userService.getPersons(this.login, this.sought, this.where, this.collectionSize, this.page - 1)
      .subscribe(
        (data: User[]) => {
          this.peoples = data;
        },
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
  }
  find() {
    this.page = 1;
    this.getPersonsNewSought();
  }
  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

}
