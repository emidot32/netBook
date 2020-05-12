import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VerificationAdminComponent } from './verification-admin.component';

describe('VerificationAdminComponent', () => {
  let component: VerificationAdminComponent;
  let fixture: ComponentFixture<VerificationAdminComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VerificationAdminComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VerificationAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
