import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VerificationAccountComponent } from './verification-account.component';

describe('VerificationAccountComponent', () => {
  let component: VerificationAccountComponent;
  let fixture: ComponentFixture<VerificationAccountComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VerificationAccountComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VerificationAccountComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
