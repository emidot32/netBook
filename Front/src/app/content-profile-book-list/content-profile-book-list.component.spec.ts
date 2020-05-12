import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentProfileBookListComponent } from './content-profile-book-list.component';

describe('ContentProfileBookListComponent', () => {
  let component: ContentProfileBookListComponent;
  let fixture: ComponentFixture<ContentProfileBookListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentProfileBookListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentProfileBookListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
