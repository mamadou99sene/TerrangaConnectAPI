import {Component, OnInit} from '@angular/core';
import {DeclarationService} from '../services/declaration.service';
import {CommonModule} from '@angular/common';
import { AppbarComponent } from "../appbar/appbar.component";
import { SidebarComponent } from "../sidebar/sidebar.component";
import { UrgenceComponent } from "../urgence/urgence.component";
import { DemandesangComponent } from "../demandesang/demandesang.component";
import { EvenementComponent } from "../evenement/evenement.component";

@Component({
  selector: 'app-dashboard',
  standalone:true,
  imports: [CommonModule, AppbarComponent, SidebarComponent, UrgenceComponent, DemandesangComponent, EvenementComponent],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css',
})
export class DashboardComponent implements OnInit{

  constructor(private declarationService :DeclarationService) {
  }
  ngOnInit() {

  }
 
  
}
