import { Component, inject, Input } from '@angular/core';
import { Router } from '@angular/router';
import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-sidebar',
  imports: [],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css'
})
export class SidebarComponent {
    private readonly keycloak = inject(Keycloak);
  @Input() isCollapsed: boolean = false;
  constructor(private router:Router)
  {
    
  }
navigateUrgences() {
  this.router.navigateByUrl("urgences");
}

navigateEvents() {
this.router.navigateByUrl("events");
  }
  navigateDemandes() {
    this.router.navigateByUrl("demandes");
 
  }
  deconnexion() {
  this.keycloak.logout();
 }
}
