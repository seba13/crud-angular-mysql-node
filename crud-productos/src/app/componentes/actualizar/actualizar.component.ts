import { Component, OnInit } from '@angular/core';
import { ProductosService, Producto, Marca} from '../../servicios/productos.service'
import { ActivatedRoute, Router } from '@angular/router'
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-actualizar',
  templateUrl: './actualizar.component.html',
  styleUrls: ['./actualizar.component.css']
})
export class ActualizarComponent implements OnInit {

  constructor(private productosService:ProductosService, private router:Router, private activatedRoute:ActivatedRoute) { }

  
  producto:Producto = {
    id_producto: '',
    nombre_producto: "",
    fecha_creacion: "",
    fecha_actualizacion: ""
  }
  listarMarca:Marca[]
  pipe:DatePipe = new DatePipe('en-US')
  fecha:Date;
  
  ngOnInit(): void {
    const idProducto:string = this.activatedRoute.snapshot.params['id'];
    this.listarMarcas();
    this.obtenerProducto(idProducto);
  }

  
  
  listarMarcas(){
    this.productosService.getMarcas().subscribe(res=>{
      console.log(res);
      this.listarMarca = <any>res;
      
      console.log(this.listarMarca)
    }, 
      err=> console.log(err)
    );
  }

  obtenerProducto(idProducto:string){
    this.productosService.getProducto(idProducto).subscribe(res=>{
      console.log(res)
      this.producto = res;
    }, err=>{
      console.log(err)
    })
  }

  

  setFecha(){
    this.producto.fecha_creacion = this.pipe.transform(this.fecha, 'yyyy/MM/dd')?.toString();
  }


  cancelar(){
    this.router.navigate(['/'])
  }

  agregarProducto(){
    
    let id = this.activatedRoute.snapshot.params['id'];

    if(this.producto.nombre_producto!='' && this.producto.valor!=undefined && this.producto.estado!=null && this.producto.id_marca!=undefined){
      delete this.producto.id_producto;
      this.productosService.editProducto(id,this.producto).subscribe();
      this.router.navigate(['/inicio'])
    }
  }
  


}
