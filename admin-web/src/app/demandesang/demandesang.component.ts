import { Component, OnInit } from '@angular/core';
import { Demande_don_sang } from '../../models/Demande_don_sang';
import { CommonModule } from '@angular/common';
import { DeclarationService } from '../services/declaration.service';

@Component({
  selector: 'app-demandesang',
  imports: [CommonModule],
  templateUrl: './demandesang.component.html',
  styleUrl: './demandesang.component.css'
})
export class DemandesangComponent implements OnInit{
  listDemandeSang:Array<Demande_don_sang>=[];
  ngOnInit(): void {
    this.loadAdminAllDemandeDonSang();
  }
  constructor(private declarationService: DeclarationService)
  {

  }
  
  
  loadAdminAllDemandeDonSang()
  {
    this.declarationService.getAdminAllDemandeDonSang().subscribe({
      next:(data)=>{
       this.listDemandeSang=data;
      },error:err => {
        console.log(err);
      }
    })
  }
  validerDemande(demande: Demande_don_sang) {
    let confirm=window.confirm("Voulez vous vraiment valider cette demande ?");
    if(confirm)
      this.declarationService.validerDemandeDonSang(demande).subscribe({
        next:(data)=>{
          console.log("Demande de sang bien validée");
          console.log(data);
        }, error(err) {
          console.log(err);
        },
      })
    }
}
