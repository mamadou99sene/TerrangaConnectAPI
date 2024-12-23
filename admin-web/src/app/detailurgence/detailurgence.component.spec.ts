import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DetailurgenceComponent } from './detailurgence.component';

describe('DetailurgenceComponent', () => {
  let component: DetailurgenceComponent;
  let fixture: ComponentFixture<DetailurgenceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DetailurgenceComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DetailurgenceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
