import { TestBed } from '@angular/core/testing';

import { ApproveService } from './approve.service';

describe('ApproveService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ApproveService = TestBed.get(ApproveService);
    expect(service).toBeTruthy();
  });
});
