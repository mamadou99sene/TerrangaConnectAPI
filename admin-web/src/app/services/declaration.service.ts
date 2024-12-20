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

  static numberDeclarationNotValided:number=0;
   headers = new HttpHeaders({
    'Content-Type': 'application/json',  
    'Accept': 'application/json',        
    'Authorization': '', 
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
    return this.http.put<UrgenceSociale>(Config.API_URL+Config.SOCIALE_SERVICE+"urgence",
      {},
      {
        headers:this.headers,
        params:{idUrgence:urgence.id }
      })
  }
  validerDemandeDonSang(demande:Demande_don_sang)
  {
    return this.http.put<Demande_don_sang>(Config.API_URL+Config.SOCIALE_SERVICE+"donSang",
       {}, 
       {
        headers:this.headers,
         params:{idDemande: demande.id}
        });
  }
  validerEvenement(event:Evenement)
  {
    return this.http.put<Evenement>(Config.API_URL+Config.SOCIALE_SERVICE+"event",
      {},
    {headers:this.headers,
      params: {idEvent:event.id}
    })
  }
  getNumberNotification()
  {
    return DeclarationService.numberDeclarationNotValided;
  }
}
