import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentBookDetailsComponent } from './content-book-details.component';

describe('ContentBookDetailsComponent', () => {
  let component: ContentBookDetailsComponent;
  let fixture: ComponentFixture<ContentBookDetailsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentBookDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentBookDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
