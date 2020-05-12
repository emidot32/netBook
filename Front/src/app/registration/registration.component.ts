import { Component, OnInit } from '@angular/core';
import {UserService} from '../_services/user.service';
import {AlertService} from '../_services/alert.service';
import {Router} from '@angular/router';
import {FormControl, FormGroup, ValidationErrors, Validators} from '@angular/forms';
import {User} from '../_models/interface';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  registerForm: FormGroup;
  model: User = {} as User;
  accountValidationMessages = {
    userName: [
      { type: 'required', message: 'Username is required' },
      { type: 'minlength', message: 'Username must be at least 2 characters long' },
      { type: 'maxlength', message: 'Username cannot be more than 15 characters long' },
      { type: 'pattern', message: 'Your login must contain only numbers and letters' }
    ],
    userSurname: [
      { type: 'required', message: 'Username is required' },
      { type: 'minlength', message: 'Username must be at least 2 characters long' },
      { type: 'maxlength', message: 'Username cannot be more than 15 characters long' },
      { type: 'pattern', message: 'Your name must contain only numbers and letters' }
    ],
    userEmail: [
      { type: 'required', message: 'Email is required' },
      { type: 'pattern', message: 'Enter a valid email' }
    ],
    userPassword: [
      { type: 'required', message: 'Password is required' },
      { type: 'minlength', message: 'Password must be at least 6 characters long' },
      { type: 'maxlength', message: 'Your password cannot be more than 15 characters long' }
    ],
  };

  constructor(private userService: UserService,
              private router: Router,
              private alertService: AlertService,
              private toastr: ToastrService) {

    this.registerForm = new FormGroup({

      userName: new FormControl('', [
        Validators.required,
        Validators.pattern('^[a-zA-Z0-9_]+$'),
        Validators.minLength(2),
        Validators.maxLength(15)
      ]),
      userEmail: new FormControl('', [
        Validators.required,
        Validators.pattern('^[_A-Za-z0-9-.]+@[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,})$'),
        Validators.minLength(6),
        Validators.maxLength(25)
      ]),
      userSurname: new FormControl('', [
        Validators.required,
        Validators.pattern('^[a-zA-Z0-9_]+$'),
        Validators.minLength(2),
        Validators.maxLength(15)]),
      userPassword: new FormControl('', [
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(15)])
    });
  }

  ngOnInit() {
  }


  // registration(event) {
  //   event.preventDefault();
  //   const target = event.target;
  //   const firstname = target.querySelector('#name').value;
  //   const secondname = target.querySelector('#lname').value;
  //   const username = target.querySelector('#username').value;
  //   const password = target.querySelector('#passwords').value;
  //
  //   this.user.firstName = firstname;
  //   this.user.lastName = secondname;
  //   this.user.username = username;
  //   this.user.password = password;
  //
  //
  //
  //   this.userService.register(this.user)
  //     .subscribe(
  //       data => {
  //         //this.alertService.success('Registration successful', true);
  //         //this.router.navigate(['/']);
  //
  //       },
  //       error => {
  //         //this.alertService.error(error);
  //         //this.loading = false;
  //         console.log(error.name);
  //         console.log(error.message);
  //
  //       });
  // }

  getValidationMessage(controlName: string) {
    const controlErrors: ValidationErrors = this.registerForm.get(controlName).errors;
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


  register() {
    this.model.username = this.registerForm.controls.userName.value;
    this.model.firstName = this.registerForm.controls.userSurname.value;
    this.model.email = this.registerForm.controls.userEmail.value;
    this.model.password = this.registerForm.controls.userPassword.value;
    this.userService.register(this.model)
      .subscribe(
        () => {
          this.toastr.success(`Registration successful! Check your email`);
          this.router.navigate(['/login']);
        },
        error => {
          this.toastr.error(error);
        });
  }

}





