import { Component, OnInit } from '@angular/core';
import { UrgenceSociale } from '../../models/UrgenceSociale';
import { DeclarationService } from '../services/declaration.service';
import { CommonModule } from '@angular/common';
import { AppbarComponent } from "../appbar/appbar.component";
import { SidebarComponent } from "../sidebar/sidebar.component";

@Component({
  selector: 'app-urgence',
  imports: [CommonModule, AppbarComponent, SidebarComponent],
  templateUrl: './urgence.component.html',
  styleUrl: './urgence.component.css'
})
export class UrgenceComponent implements OnInit{
  ngOnInit(): void {
    this.loadAdminAllUrgencesSociale();
  }
  constructor(private declarationService :DeclarationService)
  {

  }
  listUrgences:Array<UrgenceSociale>=[];
  loadAdminAllUrgencesSociale()
  {
    this.declarationService.getAdminAllUrgencesSociale().subscribe({
      next:(data)=>{
        this.listUrgences=data;
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
  valider(urgence: UrgenceSociale) {
    const validation=confirm("Voulez vous vraiment valider cette declaration d'urgence ?");
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
