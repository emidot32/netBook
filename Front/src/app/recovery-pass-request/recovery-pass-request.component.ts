import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormControl, FormGroup, ValidationErrors, Validators} from '@angular/forms';
import {ActivatedRoute, Router} from '@angular/router';
import {UserService} from '../_services/user.service';
import {first} from 'rxjs/operators';
import {AlertService} from '../_services/alert.service';
import { environment } from '../../environments/environment';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-recovery-pass-request',
  templateUrl: './recovery-pass-request.component.html',
  styleUrls: ['./recovery-pass-request.component.css']
})
export class RecoveryPassRequestComponent implements OnInit {


  public recoveryForm: FormGroup;
  public loading = false;
  public submitted = false;
  public returnUrl: string;
  public error = '';
  accountValidationMessages = {
    userEmail: [
      { type: 'required', message: 'Email is required' },
      { type: 'pattern', message: 'Enter a valid email' }
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
      userEmail: new FormControl('', [
        Validators.required,
        Validators.pattern('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$'),
      ])
    });

    // get return url from route parameters or default to '/'
    this.returnUrl = this.route.snapshot.queryParams.returnUrl || '/homeath';
  }


  // convenience getter for easy access to formAuthor fields
  get f() { return this.recoveryForm.controls; }
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
  onSubmit() {
    this.submitted = true;

    // stop here if formAuthor is invalid
    if (this.recoveryForm.invalid) {
      return;
    }

    this.loading = true;
    this.userService.recoveryPassRequest(this.f.userEmail.value)
      .subscribe(
        data => {
          this.toastr.success(`Email was sent`);
          this.router.navigate([this.returnUrl]);
        },
        error => {
          this.toastr.error(error);
        });
  }

}

