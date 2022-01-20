import { Component, OnInit } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { Marca, Producto } from 'src/app/servicios/productos.service';
import { Router} from '@angular/router';
import { ProductosService } from 'src/app/servicios/productos.service';



@Component({
  selector: 'app-listar',
  templateUrl: './listar.component.html',
  styleUrls: ['./listar.component.css']
})
export class ListarComponent implements OnInit {
  
  listarMarca:Marca[] = [];
  productosMarca:Producto[] = []
  dataSource = new MatTableDataSource<Marca>();
  mensajeAlerta:boolean = false;
  displayedColumns:string[] = ['idMarca', 'nombreMarca', 'fechaCreacion','fechaActualizacion','estadoMarca','acciones']


  constructor(private productosService:ProductosService, private router:Router) { }

  ngOnInit(): void {
    this.listarMarcas();
  }

  listarMarcas(){
      
    this.productosService.getMarcas().subscribe(res=>{
      // console.log(res);
      this.listarMarca = <any>res;
    }, err=>{
      console.log(err)
    })

  }

  validarEliminar(id:string){
    
    this.mensajeAlerta = false;
    
    this.productosService.getProductosMarca(id).subscribe(res=>{
        this.productosMarca =  <any>res;
        console.log("res"+res)
        if(this.productosMarca.length==0){
          this.mensajeAlerta = false;
          this.eliminarMarca(id)
        }else{
          this.mensajeAlerta = true;
          console.log("no se puede eliminar")
        }
    })


    
  }

 


  eliminarMarca(id:string){
      
    console.log("se puede eliminar")
    console.log(this.productosMarca)
    
      this.productosService.deleteMarca(id).subscribe((res=>{
        console.log(res);
        this.listarMarcas();
        this.mensajeAlerta = false;
      }), err=>{
          console.log(err)
      })
      }

  }
  
  

