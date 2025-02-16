import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Config } from '../../config/Config';

@Injectable({
  providedIn: 'root'
})
export class AuthentificationService {

  constructor(private http:HttpClient) { }

  login(credentiel:{email:string, password:string})
  {
    return this.http.post<any>(Config.API_URL+Config.UTILISATEUR_SERVICE+'/login', credentiel);
  }
}
