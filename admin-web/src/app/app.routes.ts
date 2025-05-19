import { Routes } from '@angular/router';
import {DashboardComponent} from './components/dashboard/dashboard.component';
import { UrgenceComponent } from './components/urgence/urgence.component';
import { EvenementComponent } from './components/evenement/evenement.component';
import { DemandesangComponent } from './components/demandesang/demandesang.component';
import { DetailurgenceComponent } from './components/detailurgence/detailurgence.component';
import { DetaileventComponent } from './components/detailevent/detailevent.component';
import { DetaildemandeComponent } from './components/detaildemande/detaildemande.component';
import { keycloakAppGuard } from './guards/keyclok-guards.guard';
import { MainContentComponent } from './components/main-content/main-content.component';
import { ForbiddenComponent } from './components/forbidden/forbidden.component';

export const routes: Routes = [
  {path:'main', component:MainContentComponent, canActivate: [keycloakAppGuard], data: {role : 'ADMIN'}, children:[
      
      {path:'dashboard', component:DashboardComponent},
      {path:'urgences', component:UrgenceComponent,},
      {path:'events', component:EvenementComponent},
      {path:'demandes', component:DemandesangComponent},
      {path:'detailsUrgence', component: DetailurgenceComponent},
      {path:'detailsEvent', component:DetaileventComponent},
      {path:'detailsDemande', component:DetaildemandeComponent},
      {path:'', redirectTo:'dashboard',pathMatch:'full'},
  ]},
      {path:'', redirectTo:'main',pathMatch:'full'},
      {path:'forbidden', component:ForbiddenComponent},


 
];


