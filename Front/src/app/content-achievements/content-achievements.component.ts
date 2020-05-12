import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {BookService} from '../_services/book.service';
import {AuthorService} from '../_services/author.service';
import {AchievementService} from '../_services/achievement.service';
import {Achievement, Author, Genre, User} from '../_models/interface';
import {Observable} from 'rxjs';
import {v4 as uuid} from 'uuid';
import {map, startWith} from 'rxjs/operators';
import {ToastrService} from 'ngx-toastr';
import {environment} from '../../environments/environment';

@Component({
  selector: 'app-content-achievements',
  templateUrl: './content-achievements.component.html',
  styleUrls: ['./content-achievements.component.css']
})
export class ContentAchievementsComponent implements OnInit {
  authorControl = new FormControl('', Validators.minLength(5));
  authors: Author[] = [];
  filteredAuthors: Observable<Author[]>;
  public achievementAuthor: Achievement = {} as Achievement;
  public achievementGenre: Achievement = {} as Achievement;
  favOrReadAuthor: string;
  favOrReadGenre: string;
  fileToUploadAuthor: File = null;
  fileNameAuthor: string;
  fileToUploadGenre: File = null;
  fileNameGenre: string;
  genres: Genre[];
  selectedGenre = '';
  allAchievements: Achievement[];
  size = 4;
  page = 0;
  endOfAchievements = false;

  formGenre: FormGroup;
  formAuthor: FormGroup;
  validationMessages = {
    title: [
      {type: 'pattern', message: 'Title can not be empty or contain forbidden symbol!'},
      {type: 'minLength', message: 'Title can not be empty or less then 2 symbols!'}
    ],
    description: [
      {type: 'pattern', message: 'Description can not be empty or contain forbidden symbol!'},
      {type: 'minLength', message: 'Description can not be empty or less then 5 symbols!'}
    ],
    numberBook: [
      {type: 'pattern', message: 'Is not a number!'},
      {type: 'min', message: 'The number must be more then 0!'}
    ]
  };
  formControlAuthor = {
    title: new FormControl('', [
      Validators.pattern('^[a-zA-Z0-9_.?!(),]+[a-zA-Z0-9_.?!(), ]+$'),
      Validators.required,
      Validators.minLength(2)
    ]),
    description: new FormControl('', [
      Validators.required,
      Validators.pattern('^[a-zA-Z0-9_.?!(),]+[a-zA-Z0-9_.?!(), ]+$'),
      Validators.minLength(5)
    ]),
    numberBook: new FormControl('', [
      Validators.pattern('^[0-9]+$'),
      Validators.required,
      Validators.min(0)
    ]),
    // author: new FormControl(),
    achievementFilePath: new FormControl()
  };
  formControlGenre = {
    title: new FormControl('', [
      Validators.pattern('^[a-zA-Z0-9_.?!(),]+[a-zA-Z0-9_.?!(), ]+$'),
      Validators.required,
      Validators.minLength(2)
    ]),
    description: new FormControl('', [
      Validators.required,
      Validators.pattern('^[a-zA-Z0-9_.?!(),]+[a-zA-Z0-9_.?!(), ]+$'),
      Validators.minLength(5)
    ]),
    numberBook: new FormControl('', [
      Validators.pattern('^[0-9]+$'),
      Validators.required,
      Validators.min(0)
    ]),
    // author: new FormControl(),
    achievementFilePath: new FormControl()
  };


  constructor(private bookService: BookService,
              private authorService: AuthorService,
              private achievementService: AchievementService,
              private toastr: ToastrService) {
  }

  ngOnInit() {
    this.authorService.getAuthors()
      .subscribe(authors => this.authors = authors);

    this.filteredAuthors = this.authorControl.valueChanges.pipe(
      startWith(''),
      map(value => this.filterString(value))
    );
    this.bookService.getGenres()
      .subscribe(genres => this.genres = genres);
    this.achievementService.getAllAchievement(this.page, this.size).subscribe(data => {
      this.allAchievements = data;
    });
    this.formAuthor = new FormGroup(this.formControlAuthor);
    this.formGenre = new FormGroup(this.formControlGenre);
  }

  filterString(value: string): Author[] {
    const filterValue = value.trim().toLowerCase();
    return this.authors.filter(author => author.fullName.toLowerCase().includes(filterValue));
  }

  getAchievements() {
    this.achievementService.getAllAchievement(this.page, this.size).subscribe(data => {
      if (data.length < this.size) {
        this.endOfAchievements = true;
      }
      this.allAchievements = this.allAchievements.concat(data);
    });
  }

  getNewAchievementPeace() {
    this.page++;
    this.getAchievements();
  }

  addAchievement(achievement: Achievement) {
            this.achievementService.addAchievement(achievement).subscribe(data => {
        if (data) {
          this.toastr.success('Achievement is added!');
          this.page = 0;
          this.allAchievements = [];
          this.getAchievements();
        } else {
          this.toastr.error('The achievement is exists!');
        }
      });
  }

  addAchievementAuthor() {
    this.achievementAuthor.title = this.formAuthor.controls.title.value;
    this.achievementAuthor.description = this.formAuthor.controls.description.value;
    this.achievementAuthor.amount = this.formAuthor.controls.numberBook.value;
    this.achievementAuthor.authorName = this.authorControl.value;
    if (this.favOrReadAuthor === 'favAuthor') {
      this.achievementAuthor.favourite = true;
      this.achievementAuthor.readBook = null;
    } else {
      this.achievementAuthor.favourite = null;
      this.achievementAuthor.readBook = true;
    }
    if (this.fileToUploadAuthor != null) {
      this.fileNameAuthor = uuid();
      this.achievementAuthor.image_path = this.fileNameAuthor;

      this.achievementService.postFile(this.fileToUploadAuthor, this.fileNameAuthor).subscribe(data => {
        },
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
    } else {
      this.achievementAuthor.image_path = 'default_achievement_photo';
    }
    this.addAchievement(this.achievementAuthor);
  }

  addAchievementGenre() {
    this.achievementGenre.title = this.formGenre.controls.title.value;
    this.achievementGenre.description = this.formGenre.controls.description.value;
    this.achievementGenre.amount = this.formGenre.controls.numberBook.value;
    this.achievementGenre.genreName = this.selectedGenre;
    if (this.favOrReadGenre === 'favGenre') {
      this.achievementGenre.favourite = true;
      this.achievementGenre.readBook = null;
    } else {
      this.achievementGenre.favourite = null;
      this.achievementGenre.readBook = true;
    }
    if (this.fileToUploadGenre != null) {
      this.fileNameGenre = uuid();
      this.achievementGenre.image_path = this.fileNameGenre;

      this.achievementService.postFile(this.fileToUploadGenre, this.fileNameGenre).subscribe(data => {},
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
    } else {
      this.achievementGenre.image_path = 'default_achievement_photo';
    }
    this.addAchievement(this.achievementGenre);
  }

  handleFileInput(files: FileList, authorOrGenre: string) {
    if (authorOrGenre === 'author') {
      this.fileToUploadAuthor = files.item(0);
      if (this.fileToUploadAuthor != null) {
        const newFileName: string = uuid();
        this.achievementService.postFile(this.fileToUploadAuthor, newFileName).subscribe(
          () => {
            this.removeTempImage(this.fileNameAuthor, authorOrGenre);
            this.fileNameAuthor = newFileName;
          },
          error => {
            this.toastr.info(`Picture size must be < 1 MB`);
          });
      }
    } else {
      this.fileToUploadGenre = files.item(0);
      if (this.fileToUploadGenre != null) {
        const newFileName: string = uuid();
        this.achievementService.postFile(this.fileToUploadGenre, newFileName).subscribe(
          () => {
            this.removeTempImage(this.fileNameGenre, authorOrGenre);
            this.fileNameGenre = newFileName;
          },
          error => {
            this.toastr.info(`Picture size must be < 1 MB`);
          });
      }
    }
  }

  removeTempImage(fileName: string, authorOrGenre: string) {
    if (authorOrGenre === 'author') {
      if (fileName !== this.achievementAuthor.image_path) {
        this.achievementService.removeFile(fileName)
          .subscribe(() => {
          });
      }
    } else {
      if (fileName !== this.achievementGenre.image_path) {
        this.achievementService.removeFile(fileName)
          .subscribe(() => {
          });
      }
    }
  }

  getPhoto(imageName: string) {
    return `${environment.apiUrl}/files/download?filename=${imageName}`;
  }

  removeAchievement(achvId: number) {
    if (window.confirm('Are you sure you want delete this achievementAuthor?')) {
      this.achievementService.removeAchievement(achvId).subscribe(() => {
        this.page = 0;
        this.allAchievements = [];
        this.getAchievements();
      });
    }
  }
}
