const swaggerJsDoc = require('swagger-jsdoc');

// Configuration Swagger
const swaggerOptions = {
  swaggerDefinition: {
    openapi: "3.0.0", // Version de l'OpenAPI
    info: {
      title: "API Documentation",
      version: "1.0.0",
      description: "Documentation de l'API avec Swagger",
    },
    servers: [
      {
        url: "http://localhost:3003", // URL de base de votre API
      },
    ],
  },
  apis: ["./routes/*.js"], // Chemin vers vos fichiers de routes
};

// Générer la documentation Swagger
const swaggerDocs = swaggerJsDoc(swaggerOptions);

module.exports = swaggerDocs;
