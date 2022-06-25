class UserModel{
  late String email;
  late String username;
  late String id;
  late String phone;
  late String profileImage;
  late String coverImage;

  late String bio;

  late bool isEmailVerification;


  UserModel.upd(
      this.username,   this.coverImage, this.bio);

  UserModel({required this.email,required this.username,required this.id,required this.phone,required this.profileImage,required this.coverImage,required this.bio,required this.isEmailVerification});
  UserModel.fromJson(Map<String,dynamic>?json){
   email= json!['email'];
   username= json['username'];
   id= json['id'];
   phone= json['phone'];
   profileImage=json['image'];
   coverImage=json['coverImage'];

   bio=json['bio'];

   isEmailVerification= json['isEmailVerification'];


  }
   Map<String,dynamic>toMap(){
    return {
      'email':email,
      'username':username,
      'id':id,
      'phone':phone,
      'image':profileImage,
      'coverImage':coverImage,

      'bio':bio,

      'isEmailVerification':isEmailVerification,


    };
  }

}