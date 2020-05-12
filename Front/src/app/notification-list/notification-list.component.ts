import {Component, OnInit} from '@angular/core';
import {NotificationService} from "../_services/notification.service";
import {Notification, User} from "../_models/interface";
import {environment} from "../../environments/environment";
import {ToastrService} from "ngx-toastr";


@Component({
  selector: 'app-notification-list',
  templateUrl: './notification-list.component.html',
  styleUrls: ['./notification-list.component.css']
})

export class NotificationListComponent implements OnInit {

  currentNotifs:Notification[];
  notifications: Notification[];
  unreadNotifications: Notification[];
  public page: number = 1;
  public collectionSize: number = 8;
  public endOfNotifs: boolean = false;

  constructor(public notificationService: NotificationService,
              private toastr: ToastrService) {
  }

  ngOnInit() {
    this.notificationService.getAllNotifications(this.collectionSize,this.page-1).subscribe((notifications) => {

      this.notifications = notifications;
      this.currentNotifs= notifications
    })
    this.notificationService.getAllUnreadNotifications(this.collectionSize,this.page-1).subscribe((unreadNotifs)=>{
      this.unreadNotifications=unreadNotifs
    })
  }
  onPageChanged(){
    if(this.currentNotifs.length===this.notifications.length){
      this.onPageChangedForAll();
    }
    if(this.currentNotifs.length===this.unreadNotifications.length){
      this.onPageChangedForUnread();
    }
  }

  onPageChangedForAll() {
    this.page = this.page + 1;
    this.getAllNotifs();

  }
  onPageChangedForUnread() {
    this.page = this.page + 1;
    this.getAllUnreadNotifs();

  }
  //call when scrolling
  getAllNotifs() {
    this.notificationService.getAllNotifications(this.collectionSize,this.page-1).subscribe(
        (notifications) => {
          if(notifications.length < this.collectionSize) this.endOfNotifs = true;
          this.notifications = this.notifications.concat(notifications);
          this.currentNotifs = this.notifications.concat(notifications);
        },
        error => {
          this.toastr.error(`${environment.errorMessage}`);
        });
  }
  getAllUnreadNotifs() {
    this.notificationService.getAllUnreadNotifications(this.collectionSize,this.page-1).subscribe(
      (notifications) => {
        if(notifications.length < this.collectionSize) this.endOfNotifs = true;
        this.unreadNotifications = this.unreadNotifications.concat(notifications);
        this.currentNotifs = this.unreadNotifications.concat(notifications);
      },
      error => {
        this.toastr.error(`${environment.errorMessage}`);
      });
  }

//getting link to go
  getNavigationLink(notification: Notification): string {
    switch (notification.notifTypeId) {
      case NotifType.addToFriend :
        return "/homeath/profile/" + notification.fromUserName.toString();
        break;
      case NotifType.friendAddBook :
        return "/homeath/search/" + notification.bookId.toString();
        break;
      case NotifType.friendGetAchiev :
        return "/homeath/profile/" + notification.fromUserName.toString();
        break;
      case NotifType.friendAddReview :
        return "/homeath/search/" + notification.bookId.toString();
        break;
      case NotifType.friendAddOverview :
        return "/homeath/search/" + notification.bookId.toString();
        break;
    }
  }

  showUnreadNotifs(){
    this.currentNotifs=this.unreadNotifications;
  }
  showAllNotifs(){
    this.currentNotifs=this.notifications;
  }

  AllNotifsMarkAsRead() {
    this.notificationService.markAllAsRead(this.notifications[0].userId).subscribe(() => {
    }, error => {
      this.toastr.error(`${environment.errorMessage}`);
    });
  }

  markOneNotifAsReadByNotifId(notification: Notification) {
    this.notificationService.markNotifAsReadByNotifId(notification).subscribe(() => {
    }, error => {
      this.toastr.error(`${environment.errorMessage}`);
    });
  }

  deleteAllNotifs() {
    this.notificationService.deleteAllNotificationsByUserId(this.notifications[0].userId).subscribe(() => {
    }, error => {
      this.toastr.error(`${environment.errorMessage}`);
    });
  }

}

//enum to understand what in switch-case, every case mean
enum NotifType {
  addToFriend = 1,
  friendAddBook,
  friendGetAchiev,
  friendAddReview,
  friendAddOverview,
}
