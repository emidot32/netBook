import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {UserService} from '../_services/user.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-verification-account',
  templateUrl: './verification-account.component.html',
  styleUrls: ['./verification-account.component.css']
})
export class VerificationAccountComponent implements OnInit {
  public token: string;
  public status: string;

  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService,
              private router: Router,
              private toastr: ToastrService) { }

  ngOnInit() {
    this.activatedRoute.queryParams.subscribe(params => {
      this.token = params.token;

    });
    this.userService.confirmUserAccountRequest(this.token)
      .subscribe(
        () => {
          this.toastr.success(`Registration successful`);
          this.router.navigate(['/login']);
        },
        error => {
          this.router.navigate(['/login']);
          this.toastr.error(error);
        });
  }


}
