import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RecoveryPassRequestComponent } from './recovery-pass-request.component';

describe('RecoveryPassRequestComponent', () => {
  let component: RecoveryPassRequestComponent;
  let fixture: ComponentFixture<RecoveryPassRequestComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RecoveryPassRequestComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RecoveryPassRequestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
