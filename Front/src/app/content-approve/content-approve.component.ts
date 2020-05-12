import {Component, OnInit} from '@angular/core';
import {Announcement, Book, NewModelBook, Review, ViewAnnouncement} from '../_models/interface';
import {ApproveService} from '../_services/approve.service';
import {BookService} from '../_services/book.service';
import {ToastrService} from 'ngx-toastr';
import {environment} from '../../environments/environment';

@Component({
  selector: 'app-content-approve',
  templateUrl: './content-approve.component.html',
  styleUrls: ['./content-approve.component.css']
})
export class ContentApproveComponent implements OnInit {
  announcements: ViewAnnouncement[];
  reviews: Review[];
  bookConfirm: NewModelBook[];
  text: any;
  itemsPerPage = 4;
  reviewPage = 0;
  collectionSize: number;
  book: NewModelBook;
  sortingBy: string;
  value: string;
  counterAnon = 0;
  counterRev = 0;
  counterBook = 0;

  constructor(private approveService: ApproveService,
              private bookService: BookService,
              private toastr: ToastrService) {
  }

  ngOnInit() {
    this.loadAnnouncements();
  }

  sort(event) {
    if (this.sortingBy === 'date') {
      this.announcements.sort((object1, object2) => {
        if (object1.releaseDate > object2.releaseDate) {
          return 1;
        }
        if (object1.releaseDate < object2.releaseDate) {
          return -1;
        }
        return 0;
      });
    }
    if (this.sortingBy === 'username') {
      this.reviews.sort((object1, object2) => {
        if (object1.userName > object2.userName) {
          return 1;
        }
        if (object1.userName < object2.userName) {
          return -1;
        }
        return 0;
      });
    }
    if (this.sortingBy === 'title') {
      this.reviews.sort((object1, object2) => {
        if (object1.title > object2.title) {
          return 1;
        }
        if (object1.title < object2.title) {
          return -1;
        }
        return 0;
      });
      this.announcements.sort((object1, object2) => {
        if (object1.title > object2.title) {
          return 1;
        }
        if (object1.title < object2.title) {
          return -1;
        }
        return 0;
      });
    }
  }

  checker() {
    if (this.value === 'anons') {
      this.loadAnnouncements();
    } else if (this.value === 'rev') {
      this.loadReviews();
    } else if (this.value === 'book') {
      this.loadBookConfirm();
    }
  }

  loadAnnouncements() {
    if (this.counterRev > 0 || this.counterBook > 0) {
      this.reviewPage = 0;
      this.counterRev = 0;
      this.counterBook = 0;
    }
    // this.counterRev = 0;
    this.counterAnon = this.counterAnon + 1;
    this.reviews = [];
    this.bookConfirm = [];
    this.value = 'anons';
    this.bookService.countAnnouncement(false).subscribe(data => {
      console.log(data);
      this.collectionSize = data;
    });
    this.approveService.getUnApproveAnnouncementList(this.reviewPage, this.itemsPerPage)
      .subscribe(books => {
        console.log(books);
        this.announcements = books;
      });
  }

  confirmAnnouncement(book) {
    this.approveService.confirmAnnouncement(book)
      .subscribe(text => {
        if (text) {
          this.toastr.success('The announcement is confirmed.');
        } else {
          this.toastr.error('Something is wrong');
        }
      });
  }

  cancelAnnouncement(book) {
    this.approveService.cancelAnnouncement(book)
      .subscribe(text => {
        if (text) {
          this.toastr.success('The announcement is canceled.');
        } else {
          this.toastr.error('Something is wrong');
        }
      });
  }

  loadReviews() {
    if (this.counterAnon > 0 || this.counterBook > 0) {
      this.reviewPage = 0;
      this.counterAnon = 0;
      this.counterBook = 0;
    }
    this.counterRev = this.counterRev + 1;
    this.announcements = [];
    this.bookConfirm = [];
    this.value = 'rev';
    this.bookService.countReviews(false).subscribe(data => {
      this.collectionSize = data;
    });
    this.approveService.getReviewForApprove(this.reviewPage, this.itemsPerPage).subscribe(data => {
      this.reviews = data;
    });
  }

  confirmReview(review) {
    this.approveService.confirmReview(review.reviewId, review.userId)
      .subscribe(data => {
        if (data) {
          this.toastr.success('The review is confirmed.');
          this.approveService.getReviewForApprove(this.reviewPage, this.itemsPerPage).subscribe(data2 => {
            this.reviews = data2;
          });
        } else {
          this.toastr.success('Something is wrong(');
        }
      });
  }

  cancelReview(review) {
    this.approveService.cancelReview(review.reviewId)
      .subscribe(data => {
        if (data) {
          this.toastr.success('The review is canceled.');
        } else {
          this.toastr.success('Something is wrong(');
        }
      });
    this.approveService.getReviewForApprove(this.reviewPage, this.itemsPerPage).subscribe(data => {
      console.log(data);
      this.reviews = data;
    });
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }


  loadBookConfirm() {
    if (this.counterAnon > 0 || this.counterRev > 0) {
      this.reviewPage = 0;
      this.counterAnon = 0;
      this.counterRev = 0;
    }
    this.counterBook = this.counterRev + 1;
    this.reviews = [];
    this.announcements = [];
    this.value = 'book';
    this.bookService.countBooksUnApprove(false).subscribe(data => {
      this.collectionSize = data;
    });
    this.approveService.getUnApproveBookList(this.reviewPage, this.itemsPerPage)
      .subscribe(books => {
        this.bookConfirm = books;
      });
  }

  confirmBook(book) {
    this.approveService.confirmBook(book)
      .subscribe(text => {
        if (text) {
          this.toastr.success('The book is confirmed.');
        } else {
          this.toastr.error('Something is wrong');
        }
      });
  }

  cancelBook(book) {
    this.approveService.cancelBook(book)
      .subscribe(text => {
        if (text) {
          this.toastr.success('The book is canceled.');
        } else {
          this.toastr.error('Something is wrong');
        }
      });
  }
}
