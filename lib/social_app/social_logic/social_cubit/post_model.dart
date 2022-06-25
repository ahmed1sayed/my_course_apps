class PostModel{
   late String     username;
   late String profileImage;
   late String    postImage;

   late String          uId;
   late String     postText;
   late String     dateTime;

   PostModel({ required this.username, required this.profileImage,required this.postImage , required this.uId, required this.dateTime,required this.postText });

   PostModel.fromJson(Map<String,dynamic>?json){
     username  =json!['username'];
     profileImage  =json['image'];
     postImage=json['coverImage'];
     uId            = json['uId'];
     postText   =json['postText'];
     dateTime   =json['dateTime'];
  }
  Map<String,dynamic>toMap(){
    return {
       'username':   username,
       'image':  profileImage,
       'coverImage':postImage,
       'uId':             uId,
       'postText':   postText,
       'dateTime':   dateTime,
    };
  }
}