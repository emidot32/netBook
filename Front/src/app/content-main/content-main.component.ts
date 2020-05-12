import { Component, OnInit } from '@angular/core';
import {BookService} from '../_services/book.service';
import {Announcement, Book, Genre} from '../_models/interface';
import {environment} from '../../environments/environment';




@Component({
  selector: 'app-content-main',
  templateUrl: './content-main.component.html',
  styleUrls: ['./content-main.component.css']
})

export class ContentMainComponent implements OnInit {
  books: Book[] = [] as Book[];
  collectionSize: number;
  page: number;
  public booksPerPage = 4;
  genres: Genre[];

  constructor(private bookService: BookService) {
    this.page = 1;
    this.loadPage();
  }


  ngOnInit() {
    this.bookService.getGenres()
      .subscribe(genres => { this.genres = genres; });

   // this.reloadData();
  }
  onPageChanged(pageNumber) {
    this.loadPage();
  }

  loadPage() {
    this.bookService.getAmountOfAnnouncement()
      .subscribe(data => {
        this.collectionSize = data as number;
      });
    // this.bookService.getAnnouncementList(this.reviewPage, this.booksPerPage)
    //   .subscribe(data => {
    //     this.announcements = data.rows;
    //     this.collectionSize = data.totalCount;
    //   });
    this.bookService.getAnnouncementListPeace(this.page, this.booksPerPage)
      .subscribe(data => {
        this.books = data;
      });
  }

  // reloadData() {
  //   this.bookService.getAnnouncementListPeace(this.reviewPage, this.booksPerPage).subscribe(data => { this.announcements = data; });
  //
  // }
  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

}
