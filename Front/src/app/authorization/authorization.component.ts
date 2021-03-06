import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, ValidationErrors, Validators} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {AuthenticationService} from '../_services/authentication.service';
import {first} from 'rxjs/operators';
import {User} from '../_models/interface';
import {Location} from '@angular/common';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-authorization',
  templateUrl: './authorization.component.html',
  styleUrls: ['./authorization.component.css']
})
export class AuthorizationComponent implements OnInit {


  loginForm: FormGroup;
  loading = false;
  submitted = false;
  returnUrl: string;
  error = '';
  accountValidationMessages = {
    userName: [
      { type: 'required', message: 'Username is required' },
      { type: 'minlength', message: 'Username must be at least 2 characters long' },
      { type: 'maxlength', message: 'Username cannot be more than 15 characters long' },
      { type: 'pattern', message: 'Your login must contain only numbers and letters' }
    ],
    userPassword: [
      { type: 'required', message: 'Password is required' },
      { type: 'minlength', message: 'Password must be at least 2 characters long' },
      { type: 'maxlength', message: 'Your password cannot be more than 15 characters long' }
    ],
  };


  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private location: Location,
    private toastr: ToastrService) {
    // redirect to home if already logged in
    if (this.authenticationService.currentUserValue) {
      this.router.navigate(['/homeath']);
    }

    this.loginForm = new FormGroup({

      userName: new FormControl('', [
        Validators.required,
        Validators.pattern('^[a-zA-Z0-9_]+$'),
        Validators.minLength(2),
        Validators.maxLength(15)
      ]),
      userPassword: new FormControl('', [
        Validators.required,
        Validators.minLength(2),
        Validators.maxLength(60)])
    });
  }

  ngOnInit() {

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/homeath';
  }


  // convenience getter for easy access to formAuthor fields
  get f() { return this.loginForm.controls; }

  getValidationMessage(controlName: string) {
    const controlErrors: ValidationErrors = this.loginForm.get(controlName).errors;
    let error = null;
    if (controlErrors != null) {
      for (const controlError in controlErrors) {
        if (controlErrors[controlError]) {

          error = this.accountValidationMessages[controlName].find((valMsg) => {
            return valMsg.type === controlError;
          });
          break;
        }
      }
    }
    return error;
  }

  login() {

    this.submitted = true;

    // stop here if formAuthor is invalid
    if (this.loginForm.invalid) {
      return;
    }
    this.loading = true;

    this.authenticationService.login(this.f.userName.value, this.f.userPassword.value)
      .pipe(first())
      .subscribe(
        data => {
          this.router.navigate([this.returnUrl]);
          // this.location.back();
        },
        error => {
          this.error = error;
          this.loading = false;
          this.toastr.error(`Invalid username/password supplied`);
        });
  }
  goBack(): void {
    this.location.back();
  }

}
