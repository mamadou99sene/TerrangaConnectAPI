const eureka=require('./config/eureka-client');
const express=require('express');
require('body-parser');
const app=express();
const swaggerUi = require('swagger-ui-express');
const swaggerDocs = require('./config/swaggerConfig.js'); // Importer la config Swagger
const  PORT=process.env.PORT || 3003;
const mongoose=require('./config/database');
const api=require('./routes/routes.js');
const bodyParser = require("body-parser");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use("/", api);
// Middleware pour servir la documentation Swagger
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));
mongoose.connection.on('error', console.error.bind(console, 'MongoDB connection error:'));
app.listen(PORT,() => {
    console.log("Serveur démmaré au port "+PORT);
   /* eureka.start(error => {
        console.log(error || 'communication service enregistré auprès d\'Eureka');
    });*/
});
