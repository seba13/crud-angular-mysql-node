import { Component, OnInit, ViewChild } from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import {ProductosService, Producto} from '../../servicios/productos.service'
import { Router } from '@angular/router'

@Component({
  selector: 'app-inicio',
  templateUrl: './inicio.component.html',
  styleUrls: ['./inicio.component.css']
})

export class InicioComponent implements OnInit {
  
  listarProductos:Producto[] = [];
  dataSource = new MatTableDataSource<Producto>();
  
  displayedColumns:string[] = ['idProducto', 'nombreProducto', 'valorProducto','fechaCreacion','fechaActualizacion','estadoProducto','idMarca','acciones',]
  
  
  @ViewChild(MatPaginator) paginator: MatPaginator;
  ngAfterViewInit() {
    this.dataSource.paginator = this.paginator;
  }

  constructor(private productoServicio:ProductosService, private router:Router) { }

  ngOnInit(): void {
    this.listarProducto();
    this.dataSource = new MatTableDataSource<Producto>(this.listarProductos);
  }

  
  listarProducto(){
    this.productoServicio.getProductos().subscribe(res=>{
      console.log(res);
      this.listarProductos = <any>res;
      
    }, 
    err=> console.log(err)
    );
  }

  eliminarProducto(id:string){
    this.productoServicio.deleteProducto(id).subscribe(res=>{
      console.log(res);
      this.listarProducto();
    },err=> console.log(err))
  }

  modificarProducto(id:string){
    this.router.navigate(['edit'+id])
  }


}

