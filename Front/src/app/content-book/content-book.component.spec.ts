import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentBookComponent } from './content-book.component';

describe('ContentBookComponent', () => {
  let component: ContentBookComponent;
  let fixture: ComponentFixture<ContentBookComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentBookComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentBookComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
