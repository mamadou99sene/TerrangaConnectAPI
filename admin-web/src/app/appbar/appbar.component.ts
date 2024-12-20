import { Component } from '@angular/core';
import { DeclarationService } from '../services/declaration.service';

@Component({
  selector: 'app-appbar',
  imports: [],
  templateUrl: './appbar.component.html',
  styleUrl: './appbar.component.css'
})
export class AppbarComponent {
  constructor(public declarationService: DeclarationService)
  {
    console.log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    console.log(declarationService.getNumberNotification());
  }

}
