import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HeaderauthComponent } from './headerauth.component';

describe('HeaderauthComponent', () => {
  let component: HeaderauthComponent;
  let fixture: ComponentFixture<HeaderauthComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HeaderauthComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HeaderauthComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
