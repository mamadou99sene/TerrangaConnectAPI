const mongoose=require('mongoose');
require('dotenv').config();
const mongoDB_URL=process.env.MONGO_DB_CLOUD_URL;
mongoose
    .set('strictQuery',true)
    .connect(mongoDB_URL)
    .then(() => {
        console.log('Connexion à la base de données réussie');
    })
    .catch((error) => {
        console.error('Erreur de connexion à la base de données :', error.message);
    });
mongoose.Promise = global.Promise;

module.exports=mongoose;