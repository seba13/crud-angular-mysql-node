import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductosService {
  
  url:string = "/api";
  urlMarca:string = this.url+'/marcas'
  constructor(private http:HttpClient) { }

  
  // obtener todos los productos
  getProductos():Observable<Object>{
    return this.http.get(this.url);
  }

  getMarcas(){
    return this.http.get(this.urlMarca);
  }

  //productos por marca
  getProductosMarca(id:string){
    return this.http.get(this.urlMarca+'/producto/'+id);
  }

  //obtener producto por id
  getProducto(id:string):Observable<Object>{
    return this.http.get(this.url+'/'+id)
  }

  getProductoNombre(nombre:string){
    return this.http.get(this.url+'/producto/'+nombre)
  }

  getMarcaNombre(nombre:string){
    return this.http.get(this.urlMarca+'/marca/'+nombre)
  }

  //obtener marca por id
  getMarca(id:string){
    return this.http.get(this.urlMarca+'/'+id);
  }

  //agregar producto
  addProducto(producto:Producto){
    return this.http.post(this.url, producto)
  }

  addMarca(marca:Marca){
    return this.http.post(this.urlMarca,marca)
  }

  //eliminar producto
  deleteProducto(id:string){
    return this.http.delete(this.url+'/'+id)
  }

  //eliminar marca
  deleteMarca(id:string){
    return this.http.delete(this.urlMarca+'/'+id);
  }

  //actualizar producto
  editProducto(id:string, producto:Producto){
    return this.http.put(this.url+'/'+id,producto);
  }

  
  //actualizar marca
  editMarca(id:string, marca:Marca){
    return this.http.put(this.urlMarca+'/'+id,marca);
  }

}


export interface Producto{

  id_producto?:string;
  nombre_producto?:string;
  valor?:number,
  fecha_creacion?:string,
  fecha_actualizacion?:string,
  estado?:number,
  id_marca?:number
}

export interface Marca{
  id_marca?:string;
  nombre_marca?:string;
  fecha_creacion?:string,
  fecha_actualizacion?:string,
  estado?:number,
}
