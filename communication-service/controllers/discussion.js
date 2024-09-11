const Discussion=require('../models/discussion');
const { default: axios } = require("axios");
const ResClient=require('../clients/clients');
module.exports={
    getAllDiscussions:async(req, res)=>
    {
        try {
            const allDiscussions= await Discussion.find().exec();
            const responseList=await Promise.all(
                allDiscussions.map(async(dis)=>
                {
                    try {
                        const user= await axios.get(ResClient.USER_API+'/'+dis.utilisateur_id);
                        const userData=user.data;
                        return {
                            ...dis._doc,
                            utilisateur:userData
                        }
                    } catch (error) {
                        console.log(error);
                        return dis;
                    } 
                }) 
            );
            res.status(200).send(responseList);
        } catch (error) {
            res.status(500).send(err);
        }
    }, 
    getDiscussionById: async (req, res) => {
        const { discussion_id } = req.params;

        try {
            const discussion = await Discussion.findById(discussion_id).exec();

            if (!discussion) {
                return res.status(404).send({ message: "Discussion introuvable" });
            }
            const userResponse=await axios.get(ResClient.USER_API+'/'+discussion.utilisateur_id);
            if(userResponse)
            {
                const userData=userResponse.data;
                const discussionInfo={
                    ...discussion._doc,
                    utilisateur:userData
                }
                res.status(200).send(discussionInfo);
            }
            else
            {
                res.status(404).send({ message: "Utilisateur introuvable" });
            }
        } catch (error) {
            res.status(500).send({ message: "Erreur lors de la récupération de la discussion" });
        }
    },
    getMessagesForDiscussionIdentifyByDeclarationId: async(req, res)=>
    {
        const {declaration_id, discussion_id}= req.params;
        try {
            const discussion=await Discussion.findOne({_id:discussion_id, 
                                                        declaration_id:declaration_id}).populate('messages').exec();
            if(!discussion)
            {
             res.status(404).send({ message: 'Discussion introuvable' });
            }
            res.status(201).send(discussion.messages);
        } catch (error) {
            console.log(error);
            res.status(500).send({message:'Erreur de recuperation des messages'});
        }
    }, 
      saveDiscussion: async (req, res) => {
        const { declaration_id, utilisateur_id}= req.body;
        try {
            // Vérifier si la discussion existe déjà
            const existingDiscussion = await Discussion.findOne({
                declaration_id:declaration_id,
                utilisateur_id:utilisateur_id
            }).exec();

            if (!existingDiscussion) {
                // Créer une nouvelle discussion si elle n'existe pas
                const newDiscussion = new Discussion({
                    declaration_id:declaration_id,
                   utilisateur_id:utilisateur_id,
                    messages: []
                });

                await newDiscussion.save();
               res.status(201).send(newDiscussion);
            }
            res.status(201).send(existingDiscussion);
        } catch (error) {
            console.log(error);
            res.status(500).send({error:error, message: 'Erreur lors de la création de la discussion'});
        }
    },
    getAllDiscussionsByDeclarationId:async(req, res)=>
        {
            const {declaration_id}=req.params;
            try {
                const allDiscussions= await Discussion.find({declaration_id:declaration_id}).exec();
                const responseList=await Promise.all(
                    allDiscussions.map(async(dis)=>
                    {
                        try {
                            const user= await axios.get(ResClient.USER_API+'/'+dis.utilisateur_id);
                            const userData=user.data;
                            return {
                                ...dis._doc,
                                utilisateur:userData
                            }
                        } catch (error) {
                            console.log(error);
                            return dis;
                        } 
                    }) 
                );
                res.status(200).send(responseList);
            } catch (error) {
                res.status(500).send(err);
            }
        }, 
}