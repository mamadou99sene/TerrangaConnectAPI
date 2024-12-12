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
      },error:err => {
        console.log(err);
      }
    })
  }
  validerEvenement(_t15: Evenement) {
    throw new Error('Method not implemented.');
    }
}
