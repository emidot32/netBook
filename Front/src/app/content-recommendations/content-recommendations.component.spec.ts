import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentRecommendationsComponent } from './content-recommendations.component';

describe('ContentRecommendationsComponent', () => {
  let component: ContentRecommendationsComponent;
  let fixture: ComponentFixture<ContentRecommendationsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentRecommendationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentRecommendationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
