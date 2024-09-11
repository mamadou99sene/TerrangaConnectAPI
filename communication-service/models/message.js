const mongoose=require('mongoose');
const MessageScheme=new mongoose.Schema({
    contenu:
    {
        type:String,
        require: true
    },
    expediteur:
    {
        type: String,
        require: true,
    }, 
    recepteur:
    {
        type:String,
        require: true
    },
    discussion_id:
    {
        type: mongoose.Schema.Types.ObjectId,
        require: true
    }
}, {
    timestamps: true,
});
module.exports=mongoose.model("Message", MessageScheme);