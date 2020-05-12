import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentApproveComponent } from './content-approve.component';

describe('ContentApproveComponent', () => {
  let component: ContentApproveComponent;
  let fixture: ComponentFixture<ContentApproveComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentApproveComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentApproveComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
