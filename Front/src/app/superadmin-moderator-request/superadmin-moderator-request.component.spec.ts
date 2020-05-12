import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SAMRequestComponent } from './superadmin-moderator-request.component';

describe('SAMRequestComponent', () => {
  let component: SAMRequestComponent;
  let fixture: ComponentFixture<SAMRequestComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SAMRequestComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SAMRequestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
