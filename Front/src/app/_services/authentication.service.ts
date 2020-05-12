import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';

import { environment } from '../../environments/environment';
import {User} from '../_models/interface';

const headers = new HttpHeaders({'Content-Type': 'application/json'});

@Injectable({ providedIn: 'root' })
export class AuthenticationService {
  private currentUserSubject: BehaviorSubject<User>;
  public currentUser: Observable<User>;
  public role: number;
  constructor(private http: HttpClient) {
    this.currentUserSubject = new BehaviorSubject<User>(JSON.parse(localStorage.getItem('currentUser')));
    this.currentUser = this.currentUserSubject.asObservable();
  }

  public get currentUserValue(): User {
    return this.currentUserSubject.value;
  }


  login(username: string, password: string) {

    const body = {username: username, password: password};
    return this.http.post<any>(`${environment.apiUrl}/user-service/signin`, body)

      .pipe(map(user => {
        this.role = user.role;
        // store user details and jwt token in local storage to keep user logged in between reviewPage refreshes
        localStorage.setItem('currentUser', JSON.stringify(user));
        this.currentUserSubject.next(user);
        return user;
      }));
  }

  refreshToken() {
    return this.http.get<User>(`${environment.apiUrl}/user-service/refresh-token`)
      .subscribe(
        (data: User) => {
          localStorage.removeItem('currentUser');
          localStorage.setItem('currentUser', JSON.stringify(data));
          this.currentUserSubject.next(data);
        });

  }

  logoutuser() {
    // remove user from local storage to log user out
    localStorage.removeItem('currentUser');
    this.currentUserSubject.next(null);
  }
}
