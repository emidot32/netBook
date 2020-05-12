import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {UserService} from '../_services/user.service';
import {AlertService} from '../_services/alert.service';

@Component({
  selector: 'app-verification-admin',
  templateUrl: './verification-admin.component.html',
  styleUrls: ['./verification-admin.component.css']
})
export class VerificationAdminComponent implements OnInit {



  public token: string;
  public status: string;
  model: any = {};
  loading = false;

  constructor(private activatedRoute: ActivatedRoute,
              private userService: UserService,
              private router: Router,
              private alertService: AlertService) { }

  ngOnInit() {
    this.activatedRoute.queryParams.subscribe(params => {
      this.token = params['token'];

    });
  }
  registerAdmin() {
    this.loading = true;
    this.userService.registerAdmin(this.model, this.token)
      .subscribe(
        data => {
          this.alertService.success('Registration of Admin successful', true);
          this.router.navigate(['/login']);
          console.log(data);
        },
        (error) => {
          this.alertService.error(error);
          console.log(error);
          this.loading = false;
        });
  }
}






// import { Component, OnInit } from '@angular/core';
// import {ActivatedRoute, Router} from '@angular/router';
// import {UserService} from '../_services/user.service';
// import {AlertService} from '../_services/alert.service';

// @Component({
//   selector: 'app-verification-admin',
//   templateUrl: './verification-admin.component.html',
//   styleUrls: ['./verification-admin.component.css']
// })
// export class VerificationAdminComponent implements OnInit {



//   public token: string;
//   public status: string;
//   model: any = {};
//   loading = false;

//   constructor(private activatedRoute: ActivatedRoute,
//               private userService: UserService,
//               private router: Router,
//               private alertService: AlertService) { }

//   ngOnInit() {
//     this.activatedRoute.queryParams.subscribe(params => {
//       this.token = params['token'];

//     });
//   }
//   registerAdmin() {
//     this.loading = true;
//     this.userService.registerAdmin(this.model, this.token)
//       .subscribe(
//         data => {
//           this.alertService.success('Registration of Admin successful', true);
//           this.router.navigate(['/login']);
//           console.log(data);
//         },
//         (error) => {
//           this.alertService.error(error);
//           console.log(error);
//           this.loading = false;
//         });
//   }
// }
