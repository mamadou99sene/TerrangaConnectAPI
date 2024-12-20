import { Routes } from '@angular/router';
import {DashboardComponent} from './dashboard/dashboard.component';
import { UrgenceComponent } from './urgence/urgence.component';
import { EvenementComponent } from './evenement/evenement.component';
import { DemandesangComponent } from './demandesang/demandesang.component';

export const routes: Routes = [
  {path:'', component:DashboardComponent},
  {path:'urgences', component:UrgenceComponent,},
  {path:'events', component:EvenementComponent},
  {path:'demandes', component:DemandesangComponent},
  {path:'', redirectTo:'/',pathMatch:'full'}
];
