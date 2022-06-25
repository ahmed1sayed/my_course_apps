abstract class SocialState{}
//todo LoginStates

class SocialInitialState extends SocialState{}
class SocialLoadingState extends SocialState{}
class SocialSuccessState extends SocialState{
  late String uId;

  SocialSuccessState(this.uId);
}
class SocialErrorState extends SocialState{
  final String error;

  SocialErrorState(this.error);
}
//todo===============================================

class NewsBottomBarState extends SocialState{}
class NewsNewPostState extends SocialState{}

//todo===============================================


class SocialImageSuccessState extends SocialState{

 }
class SocialImageErrorState extends SocialState{
  final String error;

  SocialImageErrorState(this.error);
}
//todo===============================================

class SocialCoverSuccessState extends SocialState{

}
class SocialCoverErrorState extends SocialState{
  final String error;

  SocialCoverErrorState(this.error);
}
//todo===============================================

class SocialUploadProfileImageSuccessState extends SocialState{

}
class SocialUploadProfileImageErrorState extends SocialState{
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}
//todo===============================================

class SocialUploadCoverImageSuccessState extends SocialState{

}
class SocialUploadCoverImageErrorState extends SocialState{
  final String error;

  SocialUploadCoverImageErrorState(this.error);
}
//todo===============================================

class SocialUpdateLoadingState extends SocialState{

 }
class SocialUpdateErrorState extends SocialState{
  final String error;

  SocialUpdateErrorState(this.error);
}
//todo===============================================

class SocialCreateNewPostLoadingState extends SocialState{}


class SocialCreateNewPostSuccessState extends SocialState{
  late String uId;

  SocialCreateNewPostSuccessState(this.uId);
}
class SocialCreateNewPostErrorState extends SocialState{
  final String error;

  SocialCreateNewPostErrorState(this.error);
}
//todo===============================================

class SocialUploadPostImageLoadingState extends SocialState{

}
class SocialUploadPostImageErrorState extends SocialState{
  final String error;

  SocialUploadPostImageErrorState(this.error);
}
//todo===============================================

class SocialPostImageSuccessState extends SocialState{

 }

class SocialPostImageErrorState extends SocialState{
  final String error;

  SocialPostImageErrorState(this.error);
}
//todo===============================================

class SocialGetPostSuccessState extends SocialState{

 }

class SocialGetPostErrorState extends SocialState{
  final String error;

  SocialGetPostErrorState(this.error);
}
//todo===============================================

class SocialLikePostSuccessState extends SocialState{

 }
class SocialLikePostErrorState extends SocialState{
  final String error;

  SocialLikePostErrorState(this.error);
}
//todo===============================================

class SocialCommentPostSuccessState extends SocialState{

}
class SocialCommentPostErrorState extends SocialState{
  final String error;

  SocialCommentPostErrorState(this.error);
}
//todo===============================================

class SocialGetUsersSuccessState extends SocialState{

}
class SocialGetUsersErrorState extends SocialState{
  final String error;

  SocialGetUsersErrorState(this.error);
}
//todo===============================================
class SocialGetMessageSuccessState extends SocialState{

}
class SocialGetMessageErrorState extends SocialState{
  final String error;

  SocialGetMessageErrorState(this.error);
}
//todo===============================================
class SocialSendMessageSuccessState extends SocialState{

}
class SocialSendMessageErrorState extends SocialState{
  final String error;

  SocialSendMessageErrorState(this.error);
}
//todo===============================================


//todo دا حل ابيررور كانت الصوره بتاعت البروفايل مبتجيش بسبب مشكله في السيرفر بتاع الفايربيس
/*
You are trying to connect to https, while the server is http.
use http 'in the link' and add this line to AndroidManifest.xml to allow http package to connect to server that are not secure

<application

android:usesCleartextTraffic="true"*/
