import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentEditProfileComponent } from './content-edit-profile.component';

describe('ContentEditProfileComponent', () => {
  let component: ContentEditProfileComponent;
  let fixture: ComponentFixture<ContentEditProfileComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentEditProfileComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentEditProfileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
