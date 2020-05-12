import { Injectable } from '@angular/core';

import {HttpClient, HttpParams, HttpResponse} from '@angular/common/http';

import {User, Achievement, ShortBookDescription, Message, SearchParams, Shelf, SearchIn} from '../_models/interface';
import {AuthenticationService} from '../_services/authentication.service';

import { environment } from '../../environments/environment';
import {Observable} from 'rxjs';
import {throwError} from 'rxjs';
import {catchError, map} from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }

  escaping(str: string) {
    if (str == null) { return str; }
    return String(str).replace(/[&#$%~^*<>"'`=\/\\]/g, '');
  }

  getAll() {
    return this.http.get<User[]>('/user-service/users');
  }

  register(user: User) {
    return this.http.post<Map<string, string>>(`${environment.apiUrl}/user-service/register/user`, user);
  }
  registerAdmin(user: User, token: string) {

    const body = {username: user.username, password: user.password, email: user.email, firstName: user.lastName};
    return this.http.post(`${environment.apiUrl}/user-service/register/admin?token=` + token, body );
  }

  confirmUserAccountRequest(token: string) {
    return this.http.put<Map<string, string>>(
      `${environment.apiUrl}/user-service/verification/user?token=${token}`, token);
  }

  // change password
  recoveryPass(token: string, pass: string) {
    return this.http.put<void>(
      `${environment.apiUrl}/user-service/change/password?token=${token}`, pass);
  }
  // request for recovery password
  recoveryPassRequest(email: string) {
    return this.http.post<void>(
      `${environment.apiUrl}/user-service/recovery/password`, email);
  }

  getUser(login: string) {
    return this.http.get<User>(`${environment.apiUrl}/profile/${login}`);
  }

  getAchievements(login: string) {
    return this.http.get<Achievement[]>(`${environment.apiUrl}/profile/${login}/get-achievement`);
  }

  getFriends(login: string, cnt: number, offset: number) {
    return this.http.get< User[]>(`${environment.apiUrl}/profile/${login}/friends?cnt=${cnt}&offset=${offset}`);
  }
  getFavouriteBooks(login: string, sought: string, cnt: number, offset: number) {
    return this.http.get<ShortBookDescription[]>(
      `${environment.apiUrl}/profile/${login}/favourite-books?cnt=${cnt}&offset=${offset}&sought=${sought}`);
  }
  getReadingBooks(login: string, sought: string, cnt: number, offset: number) {
    return this.http.get<ShortBookDescription[]>(
      `${environment.apiUrl}/profile/${login}/reading-books?cnt=${cnt}&offset=${offset}&sought=${sought}`);
  }
  getReadBooks(login: string, sought: string, cnt: number, offset: number) {
    return this.http.get<ShortBookDescription[]>(
      `${environment.apiUrl}/profile/${login}/read-books?cnt=${cnt}&offset=${offset}&sought=${sought}`);
  }

  edit(user: User, fileToUpload: File) {
    const formData: FormData = new FormData();
    formData.append('file', fileToUpload);
    formData.append('user', JSON.stringify(user));
    return this.http.put<User>(`${environment.apiUrl}/profile/${user.username}/edit`, formData);
  }
  getPersons(login: string, sought: string, where: SearchIn, cnt: number, offset: number) {
     return this.http.get<User[]>(`${environment.apiUrl}/find-persons/${login}?sought=${sought}&where=${
     where}&cnt=${cnt}&offset=${offset}`);
  }
  getCountOfPersons(login: string, sought: string, where: string) {
    return this.http.get<number>(
      `${environment.apiUrl}/find-persons/${login}/collection-size?sought=${sought}&where=${where}`);
  }
  addFriend(ownLogin: string, friendLogin: string) {
    return this.http.post<void>(
      `${environment.apiUrl}/profile/add-friend/${friendLogin}`, friendLogin);
  }
  isFriend(ownLogin: string, friendLogin: string) {
    return this.http.get<number>(
      `${environment.apiUrl}/profile/is-friend/${ownLogin}/${friendLogin}`);
  }
  deleteFriend(ownLogin: string, friendLogin: string) {
    return this.http.delete<void>(
      `${environment.apiUrl}/profile/delete-friend/${friendLogin}`);
  }
  updateUserBookList(login: string, bookId: number, reading: boolean, favourite: boolean, remove: boolean) {
    return this.http.put<void>(
      `${environment.apiUrl}/profile/${login}/${bookId}?reading=${reading}&favourite=${favourite}&remove=${remove}`, reading);
  }

  postFile(fileToUpload: File, fileName: string): Observable<boolean> {
    const formData: FormData = new FormData();
    formData.append('file', fileToUpload);
    formData.append('name', fileName);
    return this.http.post<boolean>(`${environment.apiUrl}/files/upload/`, formData);
  }
  getBookList(login: string, params: SearchParams) {
    return this.http.get<ShortBookDescription[]>(
      `${environment.apiUrl}/profile/${login}/book-list?reading=${params.reading}&` +
      `read=${params.read}&favourite=${params.favourite}&notset=${params.notSet}&` +
      `sortby=${params.sortBy}&` +
      `order=${params.order}&sought=${params.sought}&page=${params.page}&size=${params.size}`);
  }
  addBookBatchTo(login: string, shelf: Shelf, booksId: number[]) {
    return this.http.put<void>(
      `${environment.apiUrl}/profile/${shelf}/add-books`, booksId);
  }
  removeBookBatchFrom(login: string, shelf: Shelf, booksId: number[]) {
    return this.http.put<void>(
      `${environment.apiUrl}/profile/${shelf}/remove-books`, booksId);
  }
  removeBookBatch(login: string, booksId: number[]) {
    return this.http.delete<void>(
      `${environment.apiUrl}/profile/remove-books?booksid=${booksId}`);
  }

  removeFile(fileName: string) {
    return this.http.delete<void>(
      `${environment.apiUrl}/files/remove/${fileName}`);
  }

  isEditable(login: string) {
    return this.http.get<boolean>(
      `${environment.apiUrl}/profile/${login}/is-editable`);
  }
}




