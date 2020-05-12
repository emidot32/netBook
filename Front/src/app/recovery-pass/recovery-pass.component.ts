import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, ValidationErrors, Validators} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {UserService} from '../_services/user.service';
import {first} from 'rxjs/operators';
import {AlertService} from '../_services/alert.service';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-recovery-pass',
  templateUrl: './recovery-pass.component.html',
  styleUrls: ['./recovery-pass.component.css']
})
export class RecoveryPassComponent implements OnInit {
  public recoveryForm: FormGroup;
  public loading = false;
  public submitted = false;
  public returnUrl: string;
  public error = '';
  public token: string;
  accountValidationMessages = {
    passwordFirst: [
      { type: 'required', message: 'Password is required' },
      { type: 'minlength', message: 'Password must be at least 6 characters long' },
      { type: 'maxlength', message: 'Your password cannot be more than 15 characters long' }
    ],
    passwordSecond: [
      { type: 'required', message: 'Password is required' },
      { type: 'minlength', message: 'Password must be at least 6 characters long' },
      { type: 'maxlength', message: 'Your password cannot be more than 15 characters long' }
    ]
  };
  constructor(private userService: UserService,
              private formBuilder: FormBuilder,
              private route: ActivatedRoute,
              private router: Router,
              private alertService: AlertService,
              private toastr: ToastrService) { }

  ngOnInit() {

    this.recoveryForm = new FormGroup({
      passwordFirst: new FormControl('', [
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(15)]),
      passwordSecond: new FormControl('', [
        Validators.required,
        Validators.minLength(6),
        Validators.maxLength(15)])
    });

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams.returnUrl || '/homeath';

    this.route.queryParams.subscribe(params => {
      this.token = params.token;
    });
  }
  getValidationMessage(controlName: string) {
    const controlErrors: ValidationErrors = this.recoveryForm.get(controlName).errors;
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

  // convenience getter for easy access to formAuthor fields
  get f() { return this.recoveryForm.controls; }

  onSubmit() {
    this.submitted = true;

    if (this.recoveryForm.invalid || this.f.passwordFirst.value !==
      this.f.passwordSecond.value) {
      this.toastr.error(`Passwords do not match`);
      return;
    }

    this.loading = true;
    this.userService.recoveryPass(this.token, this.f.passwordFirst.value)
      .subscribe(
        data => {
          this.toastr.success(`Successful recovery pass`);
          this.router.navigate([this.returnUrl]);
        },
        error => {
          this.toastr.error(error);
        });
  }

}
