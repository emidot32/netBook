import { Component, OnInit } from '@angular/core';
import {BookService} from '../_services/book.service';
import { Router} from '@angular/router';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  constructor(
    private bookService: BookService,
    private router: Router
  ) { }

  ngOnInit() {
  }

  newTitle(title: string) {
    title = title.trim();
    if (!title) {
      return;
    }
    this.router.navigate(['/home/search']);
    this.bookService.changeTitle(title);
  }
}
