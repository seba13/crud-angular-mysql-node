import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {
  Marca,
  Producto,
  ProductosService,
} from '../../servicios/productos.service';

@Component({
  selector: 'app-agregar',
  templateUrl: './agregar.component.html',
  styleUrls: ['./agregar.component.css'],
})
export class AgregarComponent implements OnInit {
  listarMarca: Marca[];
  mensajeAlerta: boolean = false;
  productoInvalido: boolean = false;

  constructor(
    private productosService: ProductosService,
    private router: Router
  ) {}

  producto: Producto = {};

  ngOnInit(): void {
    this.listarMarcas();
  }

  listarMarcas() {
    this.productosService.getMarcas().subscribe(
      (res) => {
        console.log(res);
        this.listarMarca = <any>res;

        console.log(this.listarMarca);
      },
      (err) => console.log(err)
    );
  }

  cancelar() {
    this.router.navigate(['/']);
  }

  validar(): void {
    this.mensajeAlerta = false;
    this.productoInvalido = false;
    setTimeout(() => {
      console.log(this.producto);

      if (
        this.producto.nombre_producto != '' &&
        this.producto.valor != undefined &&
        this.producto.estado != null &&
        this.producto.id_marca != undefined
      ) {
        this.mensajeAlerta = false;
        if (this.producto.nombre_producto != undefined) {
          console.log('entra aca123');
          this.productosService
            .getProductoNombre(this.producto.nombre_producto)
            .subscribe(
              (res) => {
                console.log(res);
                if (res == null) {
                  this.agregarProducto();

                  this.productoInvalido = false;
                } else {
                  this.productoInvalido = true;
                }
              },
              (err) => {
                console.log(err);
              }
            );
        } else {
          console.log('entra aca4321');
        }
      } else {
        this.mensajeAlerta = true;
      }
    }, 1);
  }

  agregarProducto() {
    delete this.producto.id_producto;
    this.productosService.addProducto(this.producto).subscribe();
    this.router.navigate(['/inicio']);
  }
}
