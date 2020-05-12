import {Component, OnInit, ElementRef, ViewChild, OnDestroy} from '@angular/core';
import { Observable, Subject, Subscription, interval, fromEvent } from 'rxjs';
import { map, switchMap, tap, take, reduce} from 'rxjs/operators';
import {User, ShortBookDescription, SearchParams, Shelf, Order, BookParam} from '../_models/interface';
import {UserService} from '../_services/user.service';
import {AlertService} from '../_services/alert.service';
import { Router, ActivatedRoute } from '@angular/router';
import {AuthenticationService} from '../_services/authentication.service';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';
import {BookService} from '../_services/book.service';

@Component({
  selector: 'app-content-profile-book-list',
  templateUrl: './content-profile-book-list.component.html',
  styleUrls: ['./content-profile-book-list.component.css']
})
export class ContentProfileBookListComponent implements OnInit, OnDestroy {

  private login: string;
  public searchParams: SearchParams = {
    reading: true,
    read: true,
    favourite: true,
    notSet: true,
    sortBy: BookParam.TITLE,
    order: Order.ASC,
    sought: '',
    page: 0,
    size: 6
  };
  public books: ShortBookDescription[] = [];
  public disableEdit = false;
  public enableBathEdit = false;
  public visibleTitle = true;
  public visibleAuthors  = true;
  public visibleLikes = true;
  public visibleShelves = true;
  public visibleDatePub = true;
  public batchEditShelf = Shelf.READ;
  public endOfBooks = false;
  private changeSoughtSubscription: Subscription;

  public _Shelf = Shelf;
  public _Order = Order;
  public _BookParam = BookParam;

  @ViewChild('searchInput', {static: true})
  private input: ElementRef;
  constructor(private userService: UserService,
              private activatedRoute: ActivatedRoute,
              private router: Router,
              private authenticationService: AuthenticationService,
              private alertService: AlertService,
              private bookService: BookService,
              private toastr: ToastrService) {}

  ngOnInit() {
    window.scroll(0, 0);
    this.login = this.activatedRoute.snapshot.params.login;
    this.authenticationService.refreshToken();
    if (this.login === this.authenticationService.currentUserValue.username) {
      this.disableEdit = true;
    }
    this.getBookList();

    // ------------ subscribe when sought changing
    this.changeSoughtSubscription =  fromEvent(this.input.nativeElement, 'keyup')
    .pipe(
    switchMap(() => {
      this.searchParams.page = 0;
      this.endOfBooks = false;
      this.books = [];
      return this.userService.getBookList(this.login, this.searchParams);
    })
    )
    .subscribe(
      (data: ShortBookDescription[]) => {
          this.books = data;
        },
        error => {
          this.toastr.error(error);
        }
      );
    // ------------------------
  }

  ngOnDestroy() {
    this.changeSoughtSubscription.unsubscribe();
  }

  selectAll() {
    for (const book of this.books) {
      book.checked = true;
    }
  }
  selectNone() {
    for (const book of this.books) {
      book.checked = false;
    }
  }
  addBookBatchTo(shelf: Shelf) {
    const booksId: number[] = [];
    for (const book of this.books) {
      if (book.checked) {
        booksId.push(book.bookId);
      }
    }
    this.userService.addBookBatchTo(this.login, shelf, booksId)
      .subscribe(
        () => {
          this.toastr.success(`Books successfully added into this shelf`);
          this.books = [];
          this.find();
        },
        error => {
          this.toastr.error(error);
        });

  }
  removeBookBatchFrom(shelf: Shelf) {
    const booksId: number[] = [];
    for (const book of this.books) {
      if (book.checked) {
        booksId.push(book.bookId);
      }
    }
    this.userService.removeBookBatchFrom(this.login, shelf, booksId)
      .subscribe(
        () => {
          this.toastr.success(`Books successfully removed from this shelf`);
          this.books = [];
          this.find();
        },
        error => {
          this.toastr.error(error);
        });
  }
  removeBook(bookId: number) {
    if ( window.confirm('This will completely remove the selected books from your shelves.') ) {
      const booksId: number[] = [];
      booksId.push(bookId);
      this.userService.removeBookBatch(this.login, booksId)
        .subscribe(
          () => {
            this.toastr.success(`Book successfully removed from all shelves`);
            this.books = [];
            this.find();
          },
        error => {
          this.toastr.error(error);
        });
    }
  }
  removeBookBatch() {
    if ( window.confirm('This will completely remove the selected books from your shelves.') ) {
      const booksId: number[] = [];
      for (const book of this.books) {
        if (book.checked) {
          booksId.push(book.bookId);
        }
      }
      this.userService.removeBookBatch(this.login, booksId)
        .subscribe(
          () => {
            this.toastr.success(`Books successfully removed from all shelves`);
            this.books = [];
            this.find();
          },
        error => {
          this.toastr.error(error);
        });
    }

  }
  changeBookShelfRead(book: ShortBookDescription) {
    book.reading = false;
    const booksId: number[] = [];
    booksId.push(book.bookId);
    this.userService.addBookBatchTo(this.login, Shelf.READ, booksId)
      .subscribe(() => {},
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
  }
  changeBookShelfReading(book: ShortBookDescription) {
    book.read = false;
    const booksId: number[] = [];
    booksId.push(book.bookId);
    this.userService.addBookBatchTo(this.login, Shelf.READING, booksId)
      .subscribe(() => {},
        error => {
          this.toastr.error(error);
        });
  }
  changeBookShelfFavourite(book: ShortBookDescription) {
    const booksId: number[] = [];
    booksId.push(book.bookId);
    this.userService.addBookBatchTo(this.login, Shelf.FAVOURITE, booksId)
      .subscribe(() => {},
        error => {
          this.toastr.error(error);
        });
  }


  onSearchChange(searchValue: string) {
    this.searchParams.sought = this.userService.escaping(searchValue);
  }

  find() {
    this.searchParams.page = 0;
    this.endOfBooks = false;
    this.books = [];
    this.getBookList();
  }

  getBookList() {
    this.userService.getBookList(this.login, this.searchParams)
      .subscribe(
        (data: ShortBookDescription[]) => {
          if (data.length < this.searchParams.size) { this.endOfBooks = true; }
          this.books = this.books.concat(data);
        },
        error => {
          this.toastr.error(error);
        });
  }
  onPageChanged() {
    this.searchParams.page++;
    this.getBookList();
  }
  navigateToAuthor(author: string) {
    this.router.navigate(['/homeath/search']);
    this.bookService.changeTitle(author);
  }
  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

}
