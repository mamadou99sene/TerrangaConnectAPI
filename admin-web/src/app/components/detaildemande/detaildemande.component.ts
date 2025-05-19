import { Component } from '@angular/core';
import { Demande_don_sang } from '../../../models/Demande_don_sang';
import { Router } from '@angular/router';


@Component({
  selector: 'app-detaildemande',
  imports: [ ],
  templateUrl: './detaildemande.component.html',
  styleUrl: './detaildemande.component.css'
})
export class DetaildemandeComponent {
 demandeDon!: Demande_don_sang;
  ngOnInit(): void {
    /*this.activate.queryParams.subscribe(params=>{
      this.urgence=JSON.parse(params["urgence"]);
      console.log(this.urgence);
    })*/
   
  }
  constructor(private router: Router)
  {
    const state=this.router.getCurrentNavigation()?.extras?.state;
   this.demandeDon=state?.['demande'];
   console.log(this.demandeDon);
  }
  isCollapsed: boolean = false;
  onSidebarToggle(collapsed: boolean) {
    this.isCollapsed = collapsed;
  }
  getStatusClass() {
    switch(this.demandeDon.status) {
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
