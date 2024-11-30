import {Demandeur} from './Demandeur';

export class Demande_don_sang {
  id!:string;
  titre!:string;
  description!:string;
  demandeurId!:string;
  datePublication!:Date;
  status!:string;
  adresse!:string;
  demandeur!:Demandeur;
  classe!:string;
  rhesus!:string;
  images!:Array<string>;
}
