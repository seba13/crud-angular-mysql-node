import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ActualizarMarcasComponent } from './actualizar-marcas.component';

describe('ActualizarMarcasComponent', () => {
  let component: ActualizarMarcasComponent;
  let fixture: ComponentFixture<ActualizarMarcasComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ActualizarMarcasComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ActualizarMarcasComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
