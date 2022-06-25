class MessageModel{
  late int dateTime;
  late String sender;
  late String receiver;
  late String text;



  MessageModel({required this.dateTime,required this.sender,
    required this.receiver,required this.text, });

  MessageModel.fromJson(Map<String,dynamic>?json){
    dateTime= json!['dateTime'];
    sender= json['sender'];
    receiver= json['receiver'];
    text= json['text'];


  }
  Map<String,dynamic>toMap(){
    return {
      'dateTime':dateTime,
      'sender':sender,
      'receiver':receiver,
      'text':text,


    };
  }

}