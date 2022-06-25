class ChangeFavorModel{
  late bool status;
 late String message;
  ChangeFavorModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];

  }

}