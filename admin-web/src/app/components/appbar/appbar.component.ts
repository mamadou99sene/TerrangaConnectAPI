import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { DeclarationService } from '../../services/declaration.service';

@Component({
  selector: 'app-appbar',
  imports: [],
  templateUrl: './appbar.component.html',
  styleUrl: './appbar.component.css'
})
export class AppbarComponent implements OnInit{
username: string="Mamadou SENE";
isCollapsed = false;
@Output() sidebarToggled = new EventEmitter<boolean>();

  constructor(public declarationService: DeclarationService)
  {
    console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    console.log(declarationService.getNumberNotification());
  }
ngOnInit(): void {
  console.log(this.isCollapsed);
}

  toggleSidebar() {
    this.isCollapsed = !this.isCollapsed;
    this.sidebarToggled.emit(this.isCollapsed);
    console.log(this.isCollapsed);
  }

}
