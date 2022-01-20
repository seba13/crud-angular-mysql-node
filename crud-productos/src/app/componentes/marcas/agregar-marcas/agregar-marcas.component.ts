import { Component, OnInit } from '@angular/core';
import { Marca, ProductosService } from 'src/app/servicios/productos.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-agregar-marcas',
  templateUrl: './agregar-marcas.component.html',
  styleUrls: ['./agregar-marcas.component.css'],
})
export class AgregarMarcasComponent implements OnInit {
  marca: Marca = {};
  mensajeAlerta: boolean = false;
  marcaInvalida: boolean = false;

  constructor(
    private productosService: ProductosService,
    private router: Router
  ) {}

  ngOnInit(): void {}

  cancelar() {
    this.router.navigate(['/marcas']);
  }

  validar(): void {
    this.mensajeAlerta = false;
    this.marcaInvalida = false;
    setTimeout(() => {
      console.log(this.marca.nombre_marca);
      if (this.marca.nombre_marca != '' && this.marca.estado != null) {
        // this.mensajeAlerta = false;
        // this.agregarMarca();
        if (this.marca.nombre_marca != undefined) {
          this.productosService
            .getMarcaNombre(this.marca.nombre_marca)
            .subscribe((res) => {
              console.log(res);
              if (res == null) {
                this.mensajeAlerta = false;
                this.marcaInvalida = false;
                this.agregarMarca();
              } else {
                this.marcaInvalida = true;
              }
            }, err=>{
              console.log(err);
            });
        } else {
          this.mensajeAlerta = true;
        }
      } else {
        this.mensajeAlerta = true;
      }

      console.log(this.mensajeAlerta);
    }, 1);
  }

  agregarMarca() {
    this.productosService.addMarca(this.marca).subscribe();
    this.router.navigate(['/marcas']);
  }
}
