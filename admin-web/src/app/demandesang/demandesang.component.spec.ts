import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DemandesangComponent } from './demandesang.component';

describe('DemandesangComponent', () => {
  let component: DemandesangComponent;
  let fixture: ComponentFixture<DemandesangComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DemandesangComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DemandesangComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
