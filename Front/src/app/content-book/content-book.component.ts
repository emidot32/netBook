import { Component, OnInit } from '@angular/core';
import {Author, Book, Genre, Data} from '../_models/interface';
import {BookService} from '../_services/book.service';
import {Router} from '@angular/router';
import {AlertService} from '../_services/alert.service';
import {FormArray, FormBuilder, FormControl, FormGroup} from '@angular/forms';
import {Observable} from 'rxjs';
import {map, startWith} from 'rxjs/operators';
import {environment} from '../../environments/environment';



@Component({
  selector: 'app-content-book',
  templateUrl: './content-book.component.html',
  styleUrls: ['./content-book.component.css']
})
export class ContentBookComponent implements OnInit {

  collectionSize: number;
  page: number;
  public booksPerPage = 4;

  books: Book[];
  bookModel: Book = {} as Book;
  form: FormGroup;
  ordersData: Genre[] = [];
  // author: Author = new Author();
  dataarray: Data[] = [];
  value = 'book';

  constructor(private bookService: BookService,
              private alertService: AlertService,
              private formBuilder: FormBuilder) {
    this.page = 1;
    this.loadPage();

    this.form = this.formBuilder.group({
      orders: new FormArray([])
    });

  }

  onPageChanged(pageNumber) {
    this.loadPage();
  }

  loadPage() {
    this.bookService.getAmountOfBook()
      .subscribe(data => {
        this.collectionSize = data as number;
      });
    this.bookService.getBookListPeace(this.page, this.booksPerPage)
      .subscribe(data => {
        this.books = data;
      });
  }

  ngOnInit() {
  }
  reloadData() {
    this.bookService.getBookList().subscribe(book => { this.books = book; });
    this.bookService.getGenreList().subscribe(genres => { this.ordersData = genres;
    });
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

}
