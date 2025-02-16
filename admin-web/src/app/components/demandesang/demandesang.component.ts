import { Component, OnInit, signal } from '@angular/core';
import { Demande_don_sang } from '../../../models/Demande_don_sang';
import { CommonModule } from '@angular/common';
import { DeclarationService } from '../../services/declaration.service';
import { AppbarComponent } from '../appbar/appbar.component';
import { SidebarComponent } from '../sidebar/sidebar.component';
import { Router } from '@angular/router';

@Component({
  selector: 'app-demandesang',
  imports: [CommonModule, AppbarComponent, SidebarComponent],
  templateUrl: './demandesang.component.html',
  styleUrl: './demandesang.component.css'
})
export class DemandesangComponent implements OnInit{

  isCollapsed: boolean = false;
  onSidebarToggle(collapsed: boolean) {
    this.isCollapsed = collapsed;
  }
  listDemandeSang=signal<Array<Demande_don_sang>>([]);
  ngOnInit(): void {
    this.loadAdminAllDemandeDonSang();
  }
  constructor(private declarationService: DeclarationService, private router:Router)
  {

  }
  
  
  loadAdminAllDemandeDonSang()
  {
    this.declarationService.getAdminAllDemandeDonSang().subscribe({
      next:(data)=>{
       this.listDemandeSang.set(data);
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
    formatDate(date: Date): string {
      return new Date(date).toLocaleDateString('fr-FR', {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
        hour: 'numeric',
        minute: 'numeric'
      });
    }

    navigatedetailsDemande(demande: Demande_don_sang) {
      this.router.navigate(["/detailsDemande"], 
        {
          //queryParams:{urgence:JSON.stringify(urgence)}
          state:{demande}
        });
      }
    
}
