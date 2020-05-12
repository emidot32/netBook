import { Component, OnInit } from '@angular/core';
import {Author, Book, Data, Genre, Message, Toaster} from '../_models/interface';
import {BookService} from '../_services/book.service';
import {AlertService} from '../_services/alert.service';
import {FormArray, FormBuilder, FormControl, FormGroup, ValidationErrors, Validators} from '@angular/forms';
import {Observable} from 'rxjs';
import {first, map, startWith} from 'rxjs/operators';
import {AuthorService} from '../_services/author.service';
import {AuthenticationService} from '../_services/authentication.service';
import {ToastrService} from 'ngx-toastr';
import {v4 as uuid} from 'uuid';
import {environment} from '../../environments/environment';

@Component({
  selector: 'app-add-announcement',
  templateUrl: './add-announcement.component.html',
  styleUrls: ['./add-announcement.component.css']
})
export class AddAnnouncementComponent implements OnInit {
  bookModel: Book = {} as Book;
  optionsSelect: Array<any>;
  selectedOption: Array<any>;
  authors: Author[] = [];
  authorsSend: Array<Author>;
  counter = 0;
  currentUser: string;
  response: Toaster;
  addForm: FormGroup;
  control = new FormControl('');
  filteredAuthors: Observable<Author[]>;
  private fileToUpload: File = null;
  public imagePath = '';
  accountValidationMessages = {
    title: [
      { type: 'required', message: 'Title is required' },
      { type: 'minlength', message: 'Title must be at least 2 characters long' },
      { type: 'maxlength', message: 'Title cannot be more than 15 characters long' },
    ],
    date: [
      { type: 'required', message: 'Date is required' },
    ],
    genres: [
      { type: 'required', message: 'Genre is required' }
    ],
    imagePath: [
      { type: 'required', message: 'Image url is required' }
    ],
    pages: [
      { type: 'required', message: 'Number of pages is required' },
      { type: 'pattern', message: 'Number of pages cannot be negative or more than 6 characters long' },
      { type: 'maxlength', message: 'Your number cannot be more than 6 characters long' }
    ],
  };

  constructor(private authorService: AuthorService,
              private bookService: BookService,
              private authenticationService: AuthenticationService,
              private toastr: ToastrService) {
    this.authorsSend = [];
    this.addForm = new FormGroup({

      title: new FormControl('', [
        Validators.required,
        Validators.minLength(2),
        Validators.maxLength(15)
      ]),
      date: new FormControl('', [
        Validators.required
      ]),
      genres: new FormControl('', [
        Validators.required
      ]),
      imagePath: new FormControl('', [
        Validators.required
      ]),
      pages: new FormControl('', [
        Validators.required,
        Validators.minLength(1),
        Validators.maxLength(5),
        Validators.pattern('[0-9]{1,6}')
      ]),
      description: new FormControl('')
    });
    bookService.getGenreList().subscribe(genres => { this.optionsSelect = genres; });
    this.currentUser = this.authenticationService.currentUserValue.username;
  }

  ngOnInit() {
    this.optionsSelect = [];
    this.authorService.getAuthors()
      .subscribe(authors => { this.authors = authors; });

    this.filteredAuthors = this.control.valueChanges.pipe(
      startWith(''),
      map(value => this.filterString(value))
    );
  }

  filterString(value: string): Author[] {
    const filterValue = value.trim().toLowerCase();
    return this.authors.filter(author => author.fullName.toLowerCase().includes(filterValue));
  }
  getValidationMessage(controlName: string) {
    const controlErrors: ValidationErrors = this.addForm.get(controlName).errors;
    let error = null;
    if (controlErrors != null) {
      for (const controlError in controlErrors) {
        if (controlErrors[controlError]) {

          error = this.accountValidationMessages[controlName].find((valMsg) => {
            return valMsg.type === controlError;
          });
          break;
        }
      }
    }
    return error;
  }

  addContact(name: string) {
    if (name.length === 0) {
      return;
    }
    const tmp: Author = {authorId: this.counter, fullName: name};
    this.authorsSend.push(tmp);
    this.counter = this.counter + 1;
  }

  removeContact(name) {
    const index = this.authors.indexOf(name);
    this.authorsSend.splice(index, 1);
  }

  handleFileInput(files: FileList) {
    if (files.item(0).size / 1024 / 1024 > 1) {
      this.toastr.info(`Picture size must be < 1 MB`);
      return;
    } else if (files.item(0).type.match(/image\/*/) == null) {
      this.toastr.info(`Its not an image, please select image`);
      return;
    }
    this.fileToUpload = files.item(0);
    const reader = new FileReader();
    reader.readAsDataURL(this.fileToUpload);
    reader.onload = () => {
      this.imagePath = reader.result.toString();
    };
  }

  addAnnouncementComponent() {

    if (this.authorsSend.length === 0) {
      this.toastr.error('Author is required')
      return;
    }

    this.bookModel.title = this.addForm.controls.title.value;
    this.bookModel.releaseDate = this.addForm.controls.date.value;
    this.bookModel.genres = this.addForm.controls.genres.value;
    this.bookModel.description = this.addForm.controls.description.value;
    this.bookModel.pages = this.addForm.controls.pages.value;

    const fileName: string = uuid();
    this.bookService.postFile(this.fileToUpload, fileName).subscribe(
      () => {
        this.bookModel.imagePath = fileName;
        this.addBook();
      },
      error => {
        this.toastr.info(error);
      });
  }
  addBook() {
    this.bookService.addBook(this.bookModel, this.authorsSend, this.currentUser)
      .subscribe(
        (data) => {
          this.response = data;
          if (this.response.status === 'ok') {
            this.toastr.success(this.response.message);
          } else if (this.response.status === 'error') {
            this.toastr.error(this.response.message);
          }
        });
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

}
