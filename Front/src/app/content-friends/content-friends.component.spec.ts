import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentFriendsComponent } from './content-friends.component';

describe('ContentFriendsComponent', () => {
  let component: ContentFriendsComponent;
  let fixture: ComponentFixture<ContentFriendsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentFriendsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentFriendsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
