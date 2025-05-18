import { TestBed } from '@angular/core/testing';
import { CanActivateFn } from '@angular/router';

import { keyclokGuardsGuard } from './keyclok-guards.guard';

describe('keyclokGuardsGuard', () => {
  const executeGuard: CanActivateFn = (...guardParameters) => 
      TestBed.runInInjectionContext(() => keyclokGuardsGuard(...guardParameters));

  beforeEach(() => {
    TestBed.configureTestingModule({});
  });

  it('should be created', () => {
    expect(executeGuard).toBeTruthy();
  });
});
