import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentAchievementsComponent } from './content-achievements.component';

describe('ContentAchievementsComponent', () => {
  let component: ContentAchievementsComponent;
  let fixture: ComponentFixture<ContentAchievementsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentAchievementsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentAchievementsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
