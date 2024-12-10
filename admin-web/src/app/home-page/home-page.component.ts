import {Component, OnInit} from '@angular/core';

import {DeclarationService} from '../services/declaration.service';
import {UrgenceSociale} from '../../models/UrgenceSociale';
import {Evenement} from '../../models/Evenement';
import {Demande_don_sang} from '../../models/Demande_don_sang';

@Component({
  imports: [],
  selector: 'app-home-page',
  standalone: true,
  styleUrl: './home-page.component.css',
  templateUrl: './home-page.component.html'
})
export class HomePageComponent implements OnInit{
title:string="Mamadou";
urgenceSociales!:Array<UrgenceSociale>;
evenements!:Array<Evenement>;
demandesSang!:Array<Demande_don_sang>;
constructor(private declarationService:DeclarationService) {
}

  ngOnInit(): void {
  this.getAdminAllUrgencesSociale();
  this.getAdminAllEvenement();
  this.getAdminAllDemandeDonSang();
  }
  getAdminAllUrgencesSociale()
  {
    this.declarationService.getAdminAllUrgencesSociale().subscribe(
      {
        next:allUrgences=>
        {
          this.urgenceSociales=allUrgences;
          console.log(this.urgenceSociales);
        },error:err => {
          console.log(err)
        }})
  }
  getAdminAllEvenement()
  {
    this.declarationService.getAdminAllEvenement().subscribe(
      {next:allEvent=>{
        this.evenements=allEvent;
        console.log(this.evenements);
        },error:err => {
        console.log(err);
        }})
  }
  getAdminAllDemandeDonSang()
  {
    this.declarationService.getAdminAllDemandeDonSang().subscribe(
    {
      next:demandeSang=>{
    this.demandesSang=demandeSang;
    console.log(this.demandesSang);
    }, error:err => {console.log(err)}})}

}
