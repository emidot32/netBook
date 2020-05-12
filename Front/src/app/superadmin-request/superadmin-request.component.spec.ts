import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { SARequestComponent } from './superadmin-request.component';

describe('SARequestComponent', () => {
  let component: SARequestComponent;
  let fixture: ComponentFixture<SARequestComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ SARequestComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SARequestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
