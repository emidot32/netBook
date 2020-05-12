import { Component, OnInit } from '@angular/core';

import {Router} from '@angular/router';
import {AuthenticationService} from '../_services/authentication.service';
import {User} from '../_models/interface';
import {BookService} from '../_services/book.service';



@Component({
  selector: 'app-headerauth',
  templateUrl: './headerauth.component.html',
  styleUrls: ['./headerauth.component.css']
})
export class HeaderauthComponent implements OnInit {



  currentUser: string;
  currentRole: number;

  constructor(private router: Router,
              private authenticationService: AuthenticationService,
              private bookService: BookService) {
    // this.authenticationService.currentUser.subscribe(x => this.currentUser = x);
    this.currentUser = this.authenticationService.currentUserValue.username;
    this.currentRole = this.authenticationService.currentUserValue.role;
  }

  ngOnInit() {
  }

  newTitle(title: string) {
    title = title.trim();
    if (!title) {
      return;
    }
    this.router.navigate(['/homeath/search']);
    this.bookService.changeTitle(title);
  }

  logout() {
    this.authenticationService.logoutuser();
    this.router.navigate(['home/announcement']);
  }
}
