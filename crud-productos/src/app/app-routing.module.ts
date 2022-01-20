import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ActualizarComponent } from './componentes/actualizar/actualizar.component';
import { AgregarComponent } from './componentes/agregar/agregar.component';
import { InicioComponent } from './componentes/inicio/inicio.component';
import { AgregarMarcasComponent } from './componentes/marcas/agregar-marcas/agregar-marcas.component';
import { ActualizarMarcasComponent } from './componentes/marcas/actualizar-marcas/actualizar-marcas.component';
import { ListarComponent } from './componentes/marcas/listar/listar.component';

const routes: Routes = [
  {path:'', redirectTo:'/inicio', pathMatch: 'full'},
  {path:'inicio', component: InicioComponent},
  {path: 'add', component: AgregarComponent},
  {path: 'edit/:id', component: ActualizarComponent},
  {path: 'marcas', component: ListarComponent},
  {path: 'marcas/add', component: AgregarMarcasComponent},
  {path: 'marcas/edit/:id', component: ActualizarMarcasComponent},
  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
