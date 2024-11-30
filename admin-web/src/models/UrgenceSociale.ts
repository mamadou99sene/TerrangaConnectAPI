import {Demandeur} from './Demandeur';

export class UrgenceSociale {
  id!:string;
  titre!:string;
  description!:string;
  demandeurId!:string;
  datePublication!:Date;
  status!:string;
  lieu!:string;
  type!:string;
  demandeur!:Demandeur;
  montantRequis!:number;
  images!:Array<string>;
}
