import { Component, OnInit } from '@angular/core';
import {AuthenticationService} from '../_services/authentication.service';
import {Page, User} from '../_models/interface';
import {BookService} from '../_services/book.service';
import {environment} from '../../environments/environment';

@Component({
  selector: 'app-content-recommendations',
  templateUrl: './content-recommendations.component.html',
  styleUrls: ['./content-recommendations.component.css']
})
export class ContentRecommendationsComponent implements OnInit {
  currentUser: User;
  currentPage: Page;
  pageNumber: number;
  pageSize: number;

  constructor(private authenticationService: AuthenticationService,
              private bookService: BookService) { }

  ngOnInit() {
    this.pageNumber = 1;
    this.pageSize = 4;

    this.currentUser = this.authenticationService.currentUserValue;

    this.bookService.getSuggestions(this.currentUser.username, this.pageSize, this.pageNumber)
      .subscribe(page => this.currentPage = page);
  }

  onPageChanged() {
    this.bookService.getSuggestions(this.currentUser.username, this.pageSize, this.pageNumber)
      .subscribe(page => this.currentPage = page);
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }
}
