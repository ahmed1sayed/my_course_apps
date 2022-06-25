class LoginModel{
  late  bool status;
  late String message;
  late DataModel data;
 Map<String,dynamic> empty={ "status": false,
   "message": "لم يتم تسجيل الدخول يا قلبي",
   "data": {
     "id": 3423,
     "name": "ILoveYou",
     "email": "ahmmm0103@gmail.com",
     "phone": "5624484099",
     "image": "https://student.valuxapps.com/storage/assets/defaults/user.jpg",
     "points": 4,
     "credit": 3,
     "token": ""
   }};
  LoginModel.fromJson(Map<String,dynamic>json){
    status   =json["status"];
    message  = json["message"]??'' ;
    data   =(json["data"]!=null?DataModel.fromJson(json["data"]):DataModel.fromJson(empty["data"]));
  }
}
class DataModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  DataModel(this.id, this.name, this.email, this.phone, this.image, this.points,
      this.credit, this.token);

  DataModel.fromJson(Map<String, dynamic>json){
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"]??0;
    credit = json["credit"];
    token = json["token"];
  }
}