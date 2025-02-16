import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sidebar',
  imports: [],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css'
})
export class SidebarComponent {

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
   this.router.navigate(['/authentification'])
    }
}
