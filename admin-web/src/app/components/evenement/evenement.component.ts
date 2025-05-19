import { Component, OnInit, signal } from '@angular/core';
import { Evenement } from '../../../models/Evenement';
import { CommonModule } from '@angular/common';
import { DeclarationService } from '../../services/declaration.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-evenement',
  imports: [CommonModule],
  templateUrl: './evenement.component.html',
  styleUrl: './evenement.component.css'
})
export class EvenementComponent implements OnInit{
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
 this.router.navigate(["main/detailsEvent"],
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
