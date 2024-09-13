const express = require('express');
const CommentaireController = require('../controllers/commentaire');
const DiscussionController = require('../controllers/discussion');
const MessageController = require('../controllers/message');
const routes = express.Router();

/// Commentaires

/**
 * @swagger
 * /api/commentaires:
 *   post:
 *     summary: Créer un nouveau commentaire
 *     description: Enregistre un commentaire pour une déclaration.
 *     requestBody:
 *       description: Informations sur le commentaire à créer
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               contenu:
 *                 type: string
 *               utilisateur_id:
 *                 type: string
 *               declaration_id:
 *                 type: string
 *     responses:
 *       200:
 *         description: Commentaire créé avec succès
 */
routes.post('/api/commentaires', CommentaireController.saveCommentaire);

/**
 * @swagger
 * /api/commentaires/{id}:
 *   get:
 *     summary: Obtenir un commentaire par ID
 *     description: Renvoie un commentaire selon son ID.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID du commentaire
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Détails du commentaire
 */
routes.get('/api/commentaires/:id', CommentaireController.getCommentaireById);

/**
 * @swagger
 * /api/commentaires:
 *   get:
 *     summary: Récupérer tous les commentaires
 *     description: Renvoie une liste de tous les commentaires.
 *     responses:
 *       200:
 *         description: Liste des commentaires
 */
routes.get('/api/commentaires', CommentaireController.getAllCommentaire);

/**
 * @swagger
 * /api/declarations/{declaration_id}/commentaires:
 *   get:
 *     summary: Récupérer les commentaires d'une déclaration
 *     description: Renvoie une liste de commentaires associés à une déclaration.
 *     parameters:
 *       - in: path
 *         name: declaration_id
 *         required: true
 *         description: ID de la déclaration
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Liste des commentaires de la déclaration
 */
routes.get('/api/declarations/:declaration_id/commentaires', CommentaireController.getCommentaireByDeclarationId);

/**
 * @swagger
 * /api/commentaires/{id}:
 *   delete:
 *     summary: Supprimer un commentaire par ID
 *     description: Supprime un commentaire selon son ID.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID du commentaire
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Commentaire supprimé
 */
routes.delete('/api/commentaires/:id', CommentaireController.deleteCommentaire);

/// Discussions

/**
 * @swagger
 * /api/discussions:
 *   get:
 *     summary: Récupérer toutes les discussions
 *     description: Renvoie une liste de toutes les discussions de la plateforme.
 *     responses:
 *       200:
 *         description: Liste des discussions
 */
routes.get('/api/discussions', DiscussionController.getAllDiscussions);

/**
 * @swagger
 * /api/discussions/{discussion_id}:
 *   get:
 *     summary: Obtenir une discussion par ID
 *     description: Renvoie les détails d'une discussion selon son ID.
 *     parameters:
 *       - in: path
 *         name: discussion_id
 *         required: true
 *         description: ID de la discussion
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Détails de la discussion
 */
routes.get('/api/discussions/:discussion_id', DiscussionController.getDiscussionById);

/**
 * @swagger
 * /api/discussions:
 *   post:
 *     summary: Créer une nouvelle discussion
 *     description: Initialise une discussion sur une déclaration postée.
 *     requestBody:
 *       description: Informations sur la discussion à créer
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               declaration_id:
 *                 type: string
 *               utilisateur_id:
 *                 type: string
 *     responses:
 *       200:
 *         description: Discussion créée avec succès
 */
routes.post('/api/discussions', DiscussionController.saveDiscussion);

/**
 * @swagger
 * /api/discussions/declarations/{declaration_id}/discussions:
 *   get:
 *     summary: Récupérer toutes les discussions d'une déclaration
 *     description: Renvoie toutes les discussions associées à une déclaration.
 *     parameters:
 *       - in: path
 *         name: declaration_id
 *         required: true
 *         description: ID de la déclaration
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Liste des discussions de la déclaration
 */
routes.get('/api/discussions/declarations/:declaration_id/discussions', DiscussionController.getAllDiscussionsByDeclarationId);

/// Messages

/**
 * @swagger
 * /api/messages/{id}:
 *   get:
 *     summary: Obtenir un message par ID
 *     description: Renvoie les détails d'un message selon son ID.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID du message
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Détails du message
 */
routes.get('/api/messages/:id', MessageController.getMessageById);

/**
 * @swagger
 * /api/messages:
 *   post:
 *     summary: Envoyer un message
 *     description: Enregistre un message dans une discussion.
 *     requestBody:
 *       description: Informations sur le message à envoyer
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               contenu:
 *                 type: string
 *               expediteur:
 *                 type: string
 *               recepteur:
 *                 type: string
 *               discussion_id:
 *                 type: string
 *     responses:
 *       200:
 *         description: Message enregistré avec succès
 */
routes.post('/api/messages', MessageController.saveMessage);

/**
 * @swagger
 * /api/messages:
 *   get:
 *     summary: Récupérer tous les messages
 *     description: Renvoie une liste de tous les messages pour toutes les discussions.
 *     responses:
 *       200:
 *         description: Liste des messages
 */
routes.get('/api/messages', MessageController.getAllMessages);

/**
 * @swagger
 * /api/messages/{id}:
 *   delete:
 *     summary: Supprimer un message par ID
 *     description: Supprime un message selon son ID.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: ID du message
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Message supprimé
 */
routes.delete('/api/messages/:id', MessageController.deleteMessage);

/**
 * @swagger
 * /api/declarations/{declaration_id}/discussions/{discussion_id}/messages:
 *   get:
 *     summary: Récupérer les messages d'une discussion spécifique
 *     description: Renvoie les messages d'une discussion relative à une déclaration.
 *     parameters:
 *       - in: path
 *         name: declaration_id
 *         required: true
 *         description: ID de la déclaration
 *         schema:
 *           type: string
 *       - in: path
 *         name: discussion_id
 *         required: true
 *         description: ID de la discussion
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Liste des messages de la discussion
 */
routes.get('/api/declarations/:declaration_id/discussions/:discussion_id/messages', DiscussionController.getMessagesForDiscussionIdentifyByDeclarationId);

module.exports = routes;
