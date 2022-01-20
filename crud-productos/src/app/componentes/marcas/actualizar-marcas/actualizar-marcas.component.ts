import { Component, OnInit } from '@angular/core';
import { ProductosService, Marca } from 'src/app/servicios/productos.service';
import {Router, ActivatedRoute} from '@angular/router'


@Component({
  selector: 'app-actualizar-marcas',
  templateUrl: './actualizar-marcas.component.html',
  styleUrls: ['./actualizar-marcas.component.css']
})
export class ActualizarMarcasComponent implements OnInit {

  constructor(private productosService:ProductosService, private router:Router, private activatedRoute:ActivatedRoute) { }

  
  
  marca:Marca = {

  };
  
  
  ngOnInit(): void {
    const idMarca:string = this.activatedRoute.snapshot.params['id'];
    this.obtenerMarca(idMarca);
  }

  
  

  obtenerMarca(idMarca:string){
    this.productosService.getMarca(idMarca).subscribe(res=>{
      console.log(res)
      this.marca = res;
    }, err=>{
      console.log(err)
    })
  }


  cancelar(){
    this.router.navigate(['/marcas'])
  }

  //actualizar
  agregarMarca(){
    
    let id = this.activatedRoute.snapshot.params['id'];

    if(this.marca.nombre_marca!="" && this.marca.estado!=undefined){
      
      this.productosService.editMarca(id,this.marca).subscribe();
      this.router.navigate(['/marcas'])
    }
  }
  
}
