import { Component, inject, OnInit } from '@angular/core';
import { Router, RouterOutlet } from '@angular/router';
import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-main-content',
  imports: [RouterOutlet],
  templateUrl: './main-content.component.html',
  styleUrl: './main-content.component.css'
})
export class MainContentComponent implements OnInit{
  
  private readonly keycloak = inject(Keycloak);
  isCollapsed = false;
  user: any;

  constructor(private router: Router) {}

  async ngOnInit() {
    if (this.keycloak?.authenticated) {
      const profile = await this.keycloak.loadUserProfile();

      this.user = {
        name: `${profile?.firstName} ${profile.lastName}`,
        email: profile?.email,
        username: profile?.username
      };
    }
  }

  toggleSidebar() {
    this.isCollapsed = !this.isCollapsed;
    console.log(this.isCollapsed);
  }

  navigateUrgences() {
    this.router.navigateByUrl("main/urgences");
  }

  navigateEvents() {
    this.router.navigateByUrl("main/events");
  }
  
  navigateDemandes() {
    this.router.navigateByUrl("main/demandes");
  }
  
  deconnexion() {
    this.keycloak.logout();
  }
}
