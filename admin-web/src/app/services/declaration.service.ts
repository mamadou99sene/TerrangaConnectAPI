import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Observable} from 'rxjs';
import {UrgenceSociale} from '../../models/UrgenceSociale';
import {Evenement} from '../../models/Evenement';
import {Demande_don_sang} from '../../models/Demande_don_sang';
import {Config} from '../../config/Config';
@Injectable({
  providedIn: 'root',
})
export class DeclarationService {
   headers = new HttpHeaders({
    'Content-Type': 'application/json',  // Spécifie le type de contenu
    'Accept': 'application/json',        // Spécifie le format de la réponse attendue
    'Authorization': 'Bearer <votre_token>', // Si vous utilisez un token d'authentification
  });

  constructor(private http:HttpClient) {

  }
  getAdminAllUrgencesSociale():Observable<UrgenceSociale []>
  {
    return this.http.get<UrgenceSociale[]>(Config.API_URL+Config.SOCIALE_SERVICE+"urgence/admin");
  }
  getAdminAllEvenement():Observable<Evenement[]>
  {
    return this.http.get<Evenement[]>(Config.API_URL+Config.SOCIALE_SERVICE+"event/admin");
  }
  getAdminAllDemandeDonSang():Observable<Demande_don_sang[]>
  {
    return this.http.get<Demande_don_sang[]>(Config.API_URL+Config.SOCIALE_SERVICE+"donSang/admin");
  }

  validerUrgence(urgence:UrgenceSociale)
  {
    return this.http.put<UrgenceSociale>(Config.API_URL+Config.SOCIALE_SERVICE+"urgence?idUrgence="+urgence.id,{},{headers:this.headers});
  }
}
