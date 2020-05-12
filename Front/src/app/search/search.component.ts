import {Component, OnDestroy, OnInit} from '@angular/core';
import {BookService} from '../_services/book.service';
import {Author, Genre, NewModelBook, Page} from '../_models/interface';
import {Observable, Subscription} from 'rxjs';
import {FormControl} from '@angular/forms';
import {distinctUntilChanged, map, startWith, switchMap} from 'rxjs/operators';
import {AuthorService} from '../_services/author.service';
import {environment} from '../../environments/environment';
import {ToastrService} from 'ngx-toastr';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit, OnDestroy {
  isCollapsed = true;
  isFiltered = false;
  control = new FormControl('');
  minDate: Date;
  maxDate: Date;
  dateFrom: FormControl;
  dateTo: FormControl;
  subscriptionOnTitle: Subscription;
  genres: Genre[];
  selectedGenre: number;
  authors: Author[] = [];
  filteredAuthors: Observable<Author[]>;
  currentPage: Page;
  title: string;
  pageNumber: number;
  pageSize: number;

  constructor(
    private bookService: BookService,
    private authorService: AuthorService,
    private toastr: ToastrService
  ) {}

  ngOnInit(): void {
    this.pageNumber = 1;
    this.pageSize = 4;

    this.subscriptionOnTitle = this.bookService.currentTitle.pipe(
      distinctUntilChanged(),
      switchMap(title => (this.title = title, this.bookService.searchBookByTitle(title, this.pageSize, this.pageNumber)))
    ).subscribe(page => {
      this.currentPage = page;
    });

    this.bookService.getMinDateRelease()
      .subscribe(minDate => this.minDate = new Date(minDate));

    this.bookService.getMaxDateRelease()
      .subscribe(maxDate => this.maxDate = new Date(maxDate));

    this.bookService.getGenres()
      .subscribe(genres => this.genres = genres);

    this.authorService.getAuthors()
      .subscribe(authors => this.authors = authors);

    this.filteredAuthors = this.control.valueChanges.pipe(
      startWith(''),
      map(value => this.filterString(value))
    );
  }

  filterString(value: string): Author[] {
    const filterValue = value.trim().toLowerCase();
    return this.authors.filter(author => author.fullName.toLowerCase().includes(filterValue));
  }

  ngOnDestroy(): void {
    this.subscriptionOnTitle.unsubscribe();
  }

  showFilters() {
    if (this.isCollapsed) {
      this.selectedGenre = -1;
      this.control.setValue('');
      this.dateFrom = new FormControl(this.minDate);
      this.dateTo = new FormControl(this.maxDate);
    }
    this.isCollapsed = !this.isCollapsed;
  }

  onPageChanged() {
    if (!this.isFiltered) {
      this.bookService.searchBookByTitle(this.title, this.pageSize, this.pageNumber)
        .subscribe(page => {
          this.currentPage = page;
        });
    } else if (this.dateFrom.value === null || this.dateTo.value === null) {
      this.toastr.error('Wrong date');
    } else if (this.dateFrom.value > this.dateTo.value) {
      this.toastr.error('Date from must be less than date to');
    } else {
      let selectedAuthorId;
      if (this.control.value) {
        const selectedAuthor = this.authors.find(author => author.fullName === this.control.value);
        if (selectedAuthor) {
          selectedAuthorId = selectedAuthor.authorId;
        } else {
          this.toastr.error('Please, choose the author from list');
          return;
        }
      } else {
        selectedAuthorId = -1;
      }
      this.bookService.searchBookAdvanced(this.title, this.selectedGenre, selectedAuthorId,
        this.dateFrom.value, this.dateTo.value, this.pageSize, this.pageNumber)
        .subscribe(page => {
          this.currentPage = page;
        });
    }
  }

  setFiltered() {
    this.isFiltered = true;
    this.onPageChanged();
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }
}
