import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentChatComponent } from './content-chat.component';

describe('ContentChatComponent', () => {
  let component: ContentChatComponent;
  let fixture: ComponentFixture<ContentChatComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentChatComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentChatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
