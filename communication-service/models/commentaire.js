const mongoose=require('mongoose');
const CommentaireSchema=new mongoose.Schema({
    contenu:
        {
            type:String,
            required:true,
            default:""
        },
    utilisateur_id:
        {
            type:String,
            required: true
        },
    declaration_id:
        {
            type:String,
            required:true
        }
}, {
    timestamps: true,
});
module.exports=mongoose.model("Commentaires", CommentaireSchema);