export interface Book {
  bookId: number;
  title: string;
  authors: Array<string>;
  genres: Array<string>;
  likes: number;
  imagePath: string;
  releaseDate: string;
  language: string;
  pages: number;
  description: string;
  approved: boolean;
  /* public img: string;
   public author: string;
   public genre: string;
   public date: string;
   public language: string;*/
}

export interface Event {
  title: string;
  date: string;
  url: string;
}

export interface Announcement {
  announcmentId: number;
  title: string;
  description: string;
  image_path: string;
  releaseDate: string;
  totalCount: number;
}

export interface ViewAnnouncement {
  announcmentId: number;
  releaseDate: string;
  title: string;
  description: string;
  imagePath: string;
  authors: Array<string>;
  genres: Array<string>;
}

// export class Author {
//   id: number;
//   name: string;
// }

export interface Data {
  fullName: string;
}

export interface Genre {
  genreId: number;
  genreName: string;
}

export interface User {
  id: number;
  username: string;
  password: string;
  firstName: string;
  lastName: string;
  email: string;
  sex: string;
  country: string;
  city: string;
  status: string;
  regDate: Date;
  avatarFilePath: string;
  role: number;
  token?: string;
  checked?: boolean;
}


export interface Achievement {
  achievementId: number;
  title: string;
  description: string;
  amount: number;
  image_path: string;
  achvType: string;
  achvRuleId: number;
  authorName: string;
  genreName: string;
  favourite: boolean;
  readBook: boolean;
}

export interface ShortBookDescription {
  bookId: number;
  title: string;
  authors: string[];
  likes: number;
  imagePath: string;
  releaseDate: string;
  favourite: boolean;
  reading: boolean;
  read: boolean;
  checked: boolean;
}

export interface SearchParams {
  reading: boolean;
  read: boolean;
  favourite: boolean;
  notSet: boolean;
  sortBy: BookParam;
  order: Order;
  sought: string;
  page: number;
  size: number;
}

export interface Menu {
  name: string;
  url: string;
}

export interface Notification {
  notificationId: number;
  userId: number;
  notifDate: Date;
  isRead: boolean;
  fromUserId: number;
  notifTypeId: number;
  overviewId: number;
  reviewId: number;
  bookId: number;
  achievId: number;
  overviewName: string;
  reviewName: string;
  fromUserName: string;
  bookName: string;
  achievName: string;
  notifTitle: string;
  notifText: string;
}


export interface NewModelBook {
  bookId: number;
  title: string;
  authors: string[];
  likes: number;
  imagePath: string;
  releaseDate: string;
  pages: number;
  genres: string[];
  description: string;
}


export interface Review {
  reviewId: number;
  userId: number;
  bookId: number;
  userName: string;
  userAvatarPath: string;
  title: string;
  authors: string[];
  reviewText: string;
  rating: number;
  approved: boolean;
}

export interface Message {
  message: string;
  fromName: string;
  toId: number;
  dateTimeSend: Date;
}


export interface Genre {
  genreId: number;
  genreName: string;
}

export interface Author {
  authorId: number;
  fullName: string;
}

export interface Page {
  content: NewModelBook[];
  totalElements: number;
}

export interface Chat {
  chatId: number;
  chatName: string;
  chatAvatar: string;
}
export enum Shelf {
  READING,
  READ,
  FAVOURITE
}
export enum Order {
  ASC,
  DESC
}
export enum BookParam {
  TITLE,
  LIKES
}
export enum SearchIn {
  FRIENDS,
  ALL_USERS
}

export interface Toaster {
  status: string;
  message: string;
}
