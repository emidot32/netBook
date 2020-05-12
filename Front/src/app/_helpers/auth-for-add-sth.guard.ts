import { Injectable } from '@angular/core';
import {CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router} from '@angular/router';
import { Observable } from 'rxjs';
import {AuthenticationService} from '../_services/authentication.service';

@Injectable({
  providedIn: 'root'
})
export class AuthForAddSthGuard implements CanActivate {
  constructor(
    private router: Router,
    private authenticationService: AuthenticationService
  ) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    const currentUser = this.authenticationService.currentUserValue;
    if (currentUser) {
      // logged in so return true
      if(state.url.indexOf('homeath') == -1){
        this.router.navigate(['/homeath/announcement']);
      }
    }
    //this.router.navigate(['/login'], { queryParams: { returnUrl: state.url } });
    return true;
	}
}

