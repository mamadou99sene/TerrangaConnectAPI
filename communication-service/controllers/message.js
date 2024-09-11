const Message=require('../models/message');
const Discussion= require('../models/discussion');

module.exports={
    saveMessage: async (req, res) => {
        const { contenu, expediteur, recepteur, discussion_id } = req.body;

        try {
            const discussion = await Discussion.findById(discussion_id).exec();

            if (!discussion) {
             res.status(404).send({ message: "Discussion introuvable" });
            }

            // Créer et sauvegarder le message
            const message = await Message.create({
                contenu,
                expediteur,
                recepteur,
                discussion_id
            });
            discussion.messages.push(message._id);
            await discussion.save();
            res.status(201).send(message);
        } catch (error) {
            res.status(500).send({ error, message: "Erreur lors de l'enregistrement du message" });
        }
    },

    getMessageById: async(req, res)=>
    {
        const id=req.params.id;
        try {
            const message=await Message.findById({_id:id});
            if(message)
            {
                res.status(200).send(message);
            }
            else
                res.status(400).send({message:"Le message est introuvable"});
            
        } catch (error) {
            console.log(error);
            res.status(500).send("Erreur lors de la recuperation du message");
        }
    },
    getAllMessages: async(req, res)=>
    {
        try {
            const allMessages=await Message.find().exec();
            res.status(200).send(allMessages);
        } catch (error) {
            res.status(500).send({message:"Erreur de recuperation de la liste des messages"});
        }
    },

    
    deleteMessage:async(req, res)=>
    {
        const id=req.params.id;
        try {
            const msg=await Message.findById({_id:id});
            if(msg)
            {
                await Message.findByIdAndDelete({_id:id});
                res.status(200).send({status: true, message: "Le message a été définitivement supprimé"});
            }
        } catch (error) {
            res.status(500).send({message: "Erreur de suppréssion du message"});
        }
    }
};