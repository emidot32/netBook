import { Component} from '@angular/core';
import { environment } from '../../environments/environment';
import {Router} from '@angular/router';

@Component({
  selector: 'superadmin-moderator-request',
  templateUrl: './superadmin-moderator-request.component.html',
  styleUrls: ['./sa-styles.css']
})

export class SuperadminModeratorRequest{

	onSubmit(event: any) {
	 const adminMail = event.target.adminMail.value;
	 const currentUser = JSON.parse(localStorage.getItem('currentUser'));
	 const { token } = currentUser;
	 const headers = new Headers({
	 	'Authorization': `Bearer_${token}`
	 });
   fetch(`${environment.apiUrl}/user-service/send-moder-reg-mail`, {
  	method: 'POST',
  	headers: headers,
  	body: JSON.stringify(adminMail)
   })
   .catch(error => console.warn(error))
	}
}
