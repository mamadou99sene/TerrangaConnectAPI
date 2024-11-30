import {Demandeur} from './Demandeur';

export class Evenement {
  id!:string;
  titre!:string;
  description!:string;
  demandeurId!:string;
  datePublication!:Date;
  status!:string;
  lieu!:string;
  type!:string;
  demandeur!:Demandeur;
  dateDebut!:Date;
  dateFin!:Date;
  images!:Array<string>;
}
