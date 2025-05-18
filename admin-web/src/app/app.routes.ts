import { Routes } from '@angular/router';
import {DashboardComponent} from './components/dashboard/dashboard.component';
import { UrgenceComponent } from './components/urgence/urgence.component';
import { EvenementComponent } from './components/evenement/evenement.component';
import { DemandesangComponent } from './components/demandesang/demandesang.component';
import { DetailurgenceComponent } from './components/detailurgence/detailurgence.component';
import { DetaileventComponent } from './components/detailevent/detailevent.component';
import { DetaildemandeComponent } from './components/detaildemande/detaildemande.component';
import { keycloakAppGuard } from './guards/keyclok-guards.guard';

export const routes: Routes = [
  {path:'dashboard', component:DashboardComponent, canActivate: [keycloakAppGuard], data: {role : 'ADMIN'}, children:[
      //l'ideal serait de faire un main-container et que les routes soit des comosant fils de ce comopsant main

  ]},
  
  {path:'', component:DashboardComponent},
  {path:'urgences', component:UrgenceComponent,},
  {path:'events', component:EvenementComponent},
  {path:'demandes', component:DemandesangComponent},
  {path:'detailsUrgence', component: DetailurgenceComponent},
  {path:'detailsEvent', component:DetaileventComponent},
  {path:'detailsDemande', component:DetaildemandeComponent},
  {path:'', redirectTo:'/',pathMatch:'full'},
];


