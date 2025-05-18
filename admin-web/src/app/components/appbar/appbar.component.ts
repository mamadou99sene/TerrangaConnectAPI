import { Component, EventEmitter, inject, OnInit, Output } from '@angular/core';
import { DeclarationService } from '../../services/declaration.service';
import { AuthentificationService } from '../../services/authentification.service';
import Keycloak from 'keycloak-js';

@Component({
  selector: 'app-appbar',
  imports: [],
  templateUrl: './appbar.component.html',
  styleUrl: './appbar.component.css'
})
export class AppbarComponent implements OnInit{
private readonly keycloak = inject(Keycloak);
isCollapsed = false;
user:any
@Output() sidebarToggled = new EventEmitter<boolean>();

  constructor(public declarationService: DeclarationService, public authentificationService: AuthentificationService)
  {
    console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    console.log(declarationService.getNumberNotification());
  }
async ngOnInit() {
  console.log(this.isCollapsed);
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
    this.sidebarToggled.emit(this.isCollapsed);
    console.log(this.isCollapsed);
  }

    get userName(): Promise<string> {
    return this.keycloak.loadUserProfile().then(v => {
        if (v.username) {
          console.log(v.firstName)
            return v.username.toString();
        } else {
            throw new Error("Email is undefined");
        }
    });
}


}
