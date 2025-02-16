import { Routes } from '@angular/router';
import {DashboardComponent} from './components/dashboard/dashboard.component';
import { UrgenceComponent } from './components/urgence/urgence.component';
import { EvenementComponent } from './components/evenement/evenement.component';
import { DemandesangComponent } from './components/demandesang/demandesang.component';
import { DetailurgenceComponent } from './components/detailurgence/detailurgence.component';
import { DetaileventComponent } from './components/detailevent/detailevent.component';
import { AuthentificationComponent } from './components/authentification/authentification.component';
import { DetaildemandeComponent } from './components/detaildemande/detaildemande.component';

export const routes: Routes = [
  {path:'', component:AuthentificationComponent},
  {path:'dashboard', component:DashboardComponent},
  {path:'urgences', component:UrgenceComponent,},
  {path:'events', component:EvenementComponent},
  {path:'demandes', component:DemandesangComponent},
  {path:'detailsUrgence', component: DetailurgenceComponent},
  {path:'detailsEvent', component:DetaileventComponent},
  {path:'detailsDemande', component:DetaildemandeComponent},
  {path:'authentification', component:AuthentificationComponent},
  {path:'', redirectTo:'/',pathMatch:'full'}
];
