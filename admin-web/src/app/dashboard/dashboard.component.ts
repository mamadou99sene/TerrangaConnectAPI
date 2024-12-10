import {Component, OnInit} from '@angular/core';
import {DeclarationService} from '../services/declaration.service';
import {UrgenceSociale} from '../../models/UrgenceSociale';
import {Evenement} from '../../models/Evenement';
import {Demande_don_sang} from '../../models/Demande_don_sang';
import {CommonModule} from '@angular/common';

@Component({
  selector: 'app-dashboard',
  standalone:true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css',
})
export class DashboardComponent implements OnInit{
  listUrgences:Array<UrgenceSociale>=[];
  listEvenements:Array<Evenement>=[];
  listDemandeSang:Array<Demande_don_sang>=[];
  constructor(private declarationService :DeclarationService) {
  }
  ngOnInit() {
    this.loadAdminAllUrgencesSociale();
  }
  loadAdminAllUrgencesSociale()
  {
    this.declarationService.getAdminAllUrgencesSociale().subscribe({
      next:(data)=>{
        this.listUrgences=data;
      },error:err => {
        console.log(err);
      }
    })
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
  
  valider(urgence: UrgenceSociale) {
    let validation=confirm("Voulez vous vraiment valider cette declaration d'urgence ?");
    if(validation)
    this.declarationService.validerUrgence(urgence).subscribe({
      next:(validedUrgence)=>{
      console.log(validedUrgence);
      }, error(err) {
        console.log("++++++++++++++++++++++++++");
        console.log(err);
      },
    });
    }
}
