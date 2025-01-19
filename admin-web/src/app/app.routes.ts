import { Routes } from '@angular/router';
import {DashboardComponent} from './components/dashboard/dashboard.component';
import { UrgenceComponent } from './components/urgence/urgence.component';
import { EvenementComponent } from './components/evenement/evenement.component';
import { DemandesangComponent } from './components/demandesang/demandesang.component';
import { DetailurgenceComponent } from './components/detailurgence/detailurgence.component';
import { DetaileventComponent } from './components/detailevent/detailevent.component';

export const routes: Routes = [
  {path:'', component:DashboardComponent},
  {path:'urgences', component:UrgenceComponent,},
  {path:'events', component:EvenementComponent},
  {path:'demandes', component:DemandesangComponent},
  {path:'detailsUrgence', component: DetailurgenceComponent},
  {path:'detailsEvent', component:DetaileventComponent},
  {path:'', redirectTo:'/',pathMatch:'full'}
];
