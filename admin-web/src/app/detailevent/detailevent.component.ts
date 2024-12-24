import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Evenement } from '../../models/Evenement';
import { AppbarComponent } from "../appbar/appbar.component";
import { SidebarComponent } from "../sidebar/sidebar.component";

@Component({
  selector: 'app-detailevent',
  imports: [AppbarComponent, SidebarComponent],
  templateUrl: './detailevent.component.html',
  styleUrl: './detailevent.component.css'
})
export class DetaileventComponent implements OnInit{
  evenement!:Evenement;
  ngOnInit(): void {
    
  }
  constructor(private router: Router){
    const state=this.router.getCurrentNavigation()?.extras.state;
    this.evenement=state?.["evenement"];
  }
  getStatusClass() {
    switch(this.evenement.status) {
      case 'PENDING': return 'bg-warning';
      case 'VALIDATED': return 'bg-success';
      case 'REJECTED': return 'bg-danger';
      default: return 'bg-secondary';
    }
  }

  formatDate(date: Date): string {
    return new Date(date).toLocaleDateString('fr-FR', {
      day: 'numeric',
      month: 'long',
      year: 'numeric',
      hour: 'numeric',
      minute: 'numeric'
    });
  }

  formatMontant(montant: number): string {
    return new Intl.NumberFormat('fr-FR', {
      style: 'currency',
      currency: 'XOF'
    }).format(montant);
  }
  openImageModal(_t13: string) {
    throw new Error('Method not implemented.');
    }

}
