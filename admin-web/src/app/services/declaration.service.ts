import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';
import {UrgenceSociale} from '../../models/UrgenceSociale';
import {Evenement} from '../../models/Evenement';
import {Demande_don_sang} from '../../models/Demande_don_sang';
import {Config} from '../../config/Config';
@Injectable({
  providedIn: 'root',
})
export class DeclarationService {

  constructor(private http:HttpClient) {

  }
  getAdminAllUrgencesSociale():Observable<UrgenceSociale []>
  {
    return this.http.get<UrgenceSociale[]>(Config.API_URL+"urgence/admin");
  }
  getAdminAllEvenement():Observable<Evenement[]>
  {
    return this.http.get<Evenement[]>(Config.API_URL+"event/admin");
  }
  getAdminAllDemandeDonSang():Observable<Demande_don_sang[]>
  {
    return this.http.get<Demande_don_sang[]>(Config.API_URL+"donSang/admin");
  }
}
