import { Component, OnInit, signal } from '@angular/core';
import { Evenement } from '../../../models/Evenement';
import { CommonModule } from '@angular/common';
import { DeclarationService } from '../../services/declaration.service';
import { AppbarComponent } from '../appbar/appbar.component';
import { SidebarComponent } from '../sidebar/sidebar.component';
import { Router } from '@angular/router';

@Component({
  selector: 'app-evenement',
  imports: [CommonModule, AppbarComponent, SidebarComponent],
  templateUrl: './evenement.component.html',
  styleUrl: './evenement.component.css'
})
export class EvenementComponent implements OnInit{
  isCollapsed: boolean = false;
  onSidebarToggle(collapsed: boolean) {
    this.isCollapsed = collapsed;
  }

  listEvenements=signal<Array<Evenement>>([]);
  ngOnInit(): void {
    this.loadAdminAllEvenement();
  }
  constructor(private declarationService:DeclarationService, private router:Router){

  }
  loadAdminAllEvenement()
  {
    this.declarationService.getAdminAllEvenement().subscribe({
      next:(data)=>{
       this.listEvenements.set(data)
       data.forEach(item=>{
        if(item.status!="VALIDATED")
        {
          DeclarationService.numberDeclarationNotValided++;
        }
       })
      },error:err => {
        console.log(err);
      }
    })
  }
  validerEvenement(evenement: Evenement) {
   let confirm=window.confirm("Voulez vous vraiment valider cet evenement ?");
   if(confirm)
   {
    this.declarationService.validerEvenement(evenement).subscribe({
      next:(data)=>{
        console.log("validation éfféctuée");
        console.log(data);
      }, error(err) {
        console.log(err);
      },
    })
   }
}
navigateEvent(evenement: Evenement) {
 this.router.navigate(["/detailsEvent"],
  {
    state: {evenement},
  })
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
}
