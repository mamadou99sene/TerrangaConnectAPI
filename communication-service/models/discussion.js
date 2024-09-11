const mongoose= require('mongoose');
const DiscussionSchema= new mongoose.Schema({
    declaration_id:
    {
        type:String,
        require: true,
    },
    utilisateur_id:
    {
        type:String,
        require: true,
    },
    messages:[
        {
            type:mongoose.Schema.Types.ObjectId,
            ref:'Message',
        }
    ]
});
module.exports=mongoose.model('Discussion', DiscussionSchema);