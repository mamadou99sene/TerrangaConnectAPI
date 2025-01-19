import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UrgenceSociale } from '../../../models/UrgenceSociale';
import { CommonModule } from '@angular/common';
import { AppbarComponent } from "../appbar/appbar.component";
import { SidebarComponent } from "../sidebar/sidebar.component";

@Component({
  selector: 'app-detailurgence',
  imports: [CommonModule, AppbarComponent, SidebarComponent],
  templateUrl: './detailurgence.component.html',
  styleUrl: './detailurgence.component.css'
})
export class DetailurgenceComponent implements OnInit{
  urgence!: UrgenceSociale;
  ngOnInit(): void {
    /*this.activate.queryParams.subscribe(params=>{
      this.urgence=JSON.parse(params["urgence"]);
      console.log(this.urgence);
    })*/
   
  }
  constructor(private router: Router)
  {
    const state=this.router.getCurrentNavigation()?.extras?.state;
   this.urgence=state?.['urgence'];
   console.log(this.urgence);
  }
  isCollapsed: boolean = false;
  onSidebarToggle(collapsed: boolean) {
    this.isCollapsed = collapsed;
  }
  getStatusClass() {
    switch(this.urgence.status) {
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
