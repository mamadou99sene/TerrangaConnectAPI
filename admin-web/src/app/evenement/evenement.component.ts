import { Component, OnInit } from '@angular/core';
import { Evenement } from '../../models/Evenement';
import { CommonModule } from '@angular/common';
import { DeclarationService } from '../services/declaration.service';

@Component({
  selector: 'app-evenement',
  imports: [CommonModule],
  templateUrl: './evenement.component.html',
  styleUrl: './evenement.component.css'
})
export class EvenementComponent implements OnInit{
  listEvenements:Array<Evenement>=[];
  ngOnInit(): void {
    this.loadAdminAllEvenement();
  }
  constructor(private declarationService:DeclarationService){

  }
  loadAdminAllEvenement()
  {
    this.declarationService.getAdminAllEvenement().subscribe({
      next:(data)=>{
       this.listEvenements=data;
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
}
