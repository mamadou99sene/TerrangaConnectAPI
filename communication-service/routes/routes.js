const CommentaireController=require('../controllers/commentaire');
const routes=express.Router();


///Commentaires
// Info de la requete {contenu,utilisateur_id,declaration_id} = req.body 
routes.post('/api/commentaires', CommentaireController.saveCommentaire);
//Renvoi un commentaire sachant son id, Parametre id=req.params.id
routes.get('/api/commentaires/:id', CommentaireController.getCommentaireById);
//Renvoi tous les commentaires
routes.get('/api/commentaires', CommentaireController.getAllCommentaire);
//Renvoi une liste de commentaire par rapport a une declaration, Paramateres: declaration_id= req.params
routes.get('/api/declarations/:declaration_id/commentaires', CommentaireController.getCommentaireByDeclarationId);
//Suppression d'un commentaire sachant son identifiant. Parametre: req.params.id
routes.delete('/api/commentaires/:id', CommentaireController.deleteCommentaire);

///Discussions
const DiscussionController=require('../controllers/discussion');
//Retourne toutes les disucussions effectué au niveau de la plateforme pour toutes les declarations
//Avec pour chaque discussion, l'utilisateur qui la initié
routes.get('/api/discussions',DiscussionController.getAllDiscussions);
//Retourne la discussion dont l'identifiant est donnée en parametre
// avec l'utilisateur qui a initié la discussion. Parametre: { discussion_id } = req.params
routes.get('/api/discussions/:discussion_id', DiscussionController.getDiscussionById);
//Route pour initialiser une discussion sur une declaration posté, a appeler avant de poster 
//un message dans la discussion. Parametre: { declaration_id, utilisateur_id}= req.body;
routes.post('/api/discussions', DiscussionController.saveDiscussion);
//L'ensemble des discussion autour d'une declaration dont l'identifiant est donné
//en parametre. Parametre: {declaration_id}=req.params
routes.get('/api/discussions/declarations/:declaration_id/discussions', DiscussionController.getAllDiscussionsByDeclarationId);

///Messages
const MessageController=require('../controllers/message');
//Retourne un message dont l'id est donnée en parametre: Paramatre:req.params.id
routes.get('/api/messages/:id', MessageController.getMessageById);
//Enregistre et retourne le message. Parametre: { contenu, expediteur, recepteur, discussion_id } = req.body
routes.post('/api/messages', MessageController.saveMessage);
//Renvoi la liste de tous les messages pour toutes les discussions
routes.get('/api/messages', MessageController.getAllMessages);
//Supprime le message dont l'id est donnée en parametre
routes.delete('/api/messages/:id', MessageController.deleteMessage);
//Les messages d'une discussion relative a une declaration
//Parametre a envoyés: {declaration_id, discussion_id}= req.params;
routes.get('/api/declarations/:declaration_id/discussions/:discussion_id/messages', DiscussionController.getMessagesForDiscussionIdentifyByDeclarationId);



module.exports=routes;