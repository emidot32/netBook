import { Component, OnInit } from '@angular/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import {EventInput} from '@fullcalendar/core/structs/event';
import {SubscriptionLike} from 'rxjs';
import {BookService} from '../_services/book.service';
import {AuthorService} from '../_services/author.service';
import {AuthenticationService} from '../_services/authentication.service';
import {DatePipe} from '@angular/common';
import {NewModelBook} from '../_models/interface';

@Component({
  selector: 'app-content-calendar',
  templateUrl: './content-calendar.component.html',
  styleUrls: ['./content-calendar.component.css'],
  providers: [DatePipe]
})
export class ContentCalendarComponent implements OnInit {

  books: NewModelBook[] = [];
  currentUser: string;
  calendarPlugins = [dayGridPlugin];
  calendarEvents: EventInput[] = [
    //  { title: 'Test', date: '2019-12-13', url: 'homeath/search/2', color: '#378006'},
    // { title: 'Test2', date: '2019-11-12', allDay: true }
  ];
  value: string;
  subscription: SubscriptionLike;
  today: string = Date.now().toString();

  constructor(private bookService: BookService,
              private authenticationService: AuthenticationService,
              private datePipe: DatePipe) {
    this.currentUser = this.authenticationService.currentUserValue.username;
    this.today = this.datePipe.transform(this.today, 'yyyy-MM-dd');
    this.showAll();
  }


  ngOnInit() {

  }

  addColor() {
    for (let i = 0; i < this.calendarEvents.length; i++) {
      if (this.calendarEvents[i].date > this.today) {
        this.calendarEvents[i].color = '#378006';
      }else {
        this.calendarEvents[i].color = '#d40006';
      }
    }
  }
  addURL(data) {
    for (let i = 0; i < this.calendarEvents.length; i++) {
      let url = 'homeath/search/' + data[i].id;
      this.calendarEvents[i].url =  url;
    }
  }

  showPersonalize() {
    this.value = 'personalize';
    this.subscription = this.bookService.getCalendarAnnouncement(this.value, this.currentUser)
      .subscribe(data => {
        this.calendarEvents = data;
        this.addColor();
        this.addURL(data);
      });
  }

  showAll() {
    this.value = 'all';
    this.bookService.getCalendarAnnouncement(this.value, this.currentUser)
      .subscribe(data => {
        this.calendarEvents = data;
        this.addColor();
        this.addURL(data);
      });
  }

}
