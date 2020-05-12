import { Injectable } from '@angular/core';
import {Observable} from 'rxjs';
import {Author, Book} from '../_models/interface';
import {environment} from '../../environments/environment';
import {HttpClient} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class AuthorService {

  constructor(private http: HttpClient) { }

  getAuthors(): Observable<Author[]> {
    return this.http.get<Author[]>(`${environment.apiUrl}/book-service/authors`);
  }
}
