const { default: axios } = require("axios");
const Commentaire=require("../models/commentaire");
const ResClient=require('../clients/clients');
module.exports={
    saveCommentaire: async (req,res)=>
    {
        const {contenu,utilisateur_id,declaration_id}=req.body;
        try {
            const commentaire=await Commentaire.create({
                contenu:contenu,
                utilisateur_id:utilisateur_id,
                declaration_id:declaration_id
            });
            res.status(200).send(commentaire);
        }
        catch (err) {
            console.log(err);
            res.status(500).send({
                error:err,
                message:"Impossible d'enregistrer ce commentaire"
            });
        }
    },
    getCommentaireById:async (req, res)=>
    {
        const id=req.params.id;
        try {
            const commentaire=await Commentaire.findById({_id:id}).exec();
            if (commentaire)
            {
                const userResponse=await axios.get(ResClient.USER_API+'/'+commentaire.utilisateur_id);
                if(userResponse)
                {
                    const utilisateur=userResponse.data;
                    const commentUser={
                        ...commentaire._doc,
                        utilisateur:utilisateur
                    };
                    res.status(200).send(commentUser);
                }
                else {
                    res.status(404).send({ message: "Utilisateur introuvable" });
                }
            }
            else
                res.status(400).send({message:"Commentaire introuvable"});
        }
        catch (e) {
            console.log(e);
            res.status(500).send(e);
        }

    },
    getAllCommentaire: async (req, res)=>
    {
        try {
            const commentaires=await Commentaire.find();
            const responseList=await Promise.all(
                commentaires.map(async (com)=>
                    {
                        try {
                            const utilisateur=await axios.get(ResClient.USER_API+'/'+com.utilisateur_id);
                        const commentUser=utilisateur.data;
                        return {
                            ...com._doc,
                            utilisateur:commentUser
                        };
                        } catch (error) {
                            return com;
                        }
                    }
                )
            );
            res.status(200).send(responseList);
            
        }
        catch (error) {
            console.log(error);
            res.status(500).send({message:"Erreur de recupération des commentaires"});
        }
    },
    getCommentaireByDeclarationId:async(req, res)=>
    {
        const {declaration_id}=req.params;
        try {
            const commentaires=await Commentaire.find({declaration_id:declaration_id}).exec();
           const commentairesList=await Promise.all(
                commentaires.map(async (com)=>
                {
                    try { 
                    const userResponse= await axios.get(ResClient.USER_API+'/'+com.utilisateur_id);
                    const userData=userResponse.data;
                    return {
                        ...com._doc,
                        utilisateur:userData,
                    }
                    } catch (error) {
                        return com;
                    }
                }

                )
            );
            res.status(200).send(commentairesList);
        } catch (error) {
            res.status(500).send({message:"Impossible de retourner les commentaires pour cette declaration"});
        }
    },
    deleteCommentaire:async(req, res)=>
        {
            let id=req.params.id;
            try {
                const commentaire=await Commentaire.findById({_id:id}).exec();
                if(commentaire)
                {
                    await Commentaire.findOneAndDelete({_id:id});
                    res.status(200).send({status:true, message: "Le commentaire est supprimé"});
                }
                else
                    res.status(400).send({message: 'Le commentaire specifié est introuvable'});
            } catch (error) {
                res.status(500).send("Erreur de suppression du commentaire");
            }
        },
  
};