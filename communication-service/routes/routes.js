const CommentaireController=require('../controllers/commentaire');
const express=require('express');
const routes=express.Router();


///Commentaires
routes.post('/api/commentaires', CommentaireController.saveCommentaire);
routes.get('/api/commentaires/:id', CommentaireController.getCommentaireById);
routes.get('/api/commentaires', CommentaireController.getAllCommentaire);
routes.get('/api/declarations/:id/commentaires', CommentaireController.getCommentaireByDeclarationId);
routes.delete('/api/commentaires/:id', CommentaireController.deleteCommentaire);


///Messages
const MessageController=require('../controllers/message');
routes.get('/api/messages/:id', MessageController.getMessageById);
routes.post('/api/messages', MessageController.saveMessage);
routes.get('/api/messages', MessageController.getAllMessages);
routes.delete('/api/messages/:id', MessageController.deleteMessage);

///Discussions
const DiscussionController=require('../controllers/discussion');
routes.get('/api/discussions',DiscussionController.getAllDiscussions);
routes.get('/api/discussions/:discussion_id', DiscussionController.getDiscussionById);
routes.post('/api/discussions', DiscussionController.saveDiscussion);
routes.get('/api/discussions/declarations/:declaration_id/utilisateurs/:utilisateur_id', DiscussionController.getDiscussionByDeclarationId);
routes.get('/api/declarations/:declaration_id/discussions/:discussion_id/messages', DiscussionController.getMessagesForDiscussionIdentifyByDeclarationId);
module.exports=routes;