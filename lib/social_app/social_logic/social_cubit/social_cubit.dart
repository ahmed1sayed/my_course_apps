
 import 'dart:io';

import 'package:ahmed_new_test/social_app/social_logic/social_cubit/post_model.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/shat_message_model.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:image_picker/image_picker.dart';

 import '../../../shope_app/shope_logic/end_points.dart';
import '../../social_pages/mean_screens/feeds.dart';
 import '../../social_pages/mean_screens/post.dart';
import '../../social_pages/mean_screens/settings.dart';
import '../../social_pages/mean_screens/shat.dart';
import '../../social_pages/mean_screens/users.dart';
import '../login_cubit/user_model.dart';
 import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialState> {
  SocialCubit() :super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

    UserModel? userModel;

  Future<void> getData() async {
    emit(SocialLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      print(value.data().toString());
       emit(SocialSuccessState(uId));
    }).catchError((error) {
      print(error.toString());

      emit(SocialErrorState(error.toString()));
    });
  }
  //todo==========================================================================

  List<PostModel> postsList=[];
  List<String> postsId=[];
  List<int> likes=[];
  List<int> comments=[];
  void getPosts(){

    FirebaseFirestore.instance.collection('posts').get().then((value)  {
      value.docs.forEach((element) async {

        await    element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);

          /* commentsText.add(value.docs.toString());*/
          emit(SocialGetPostSuccessState( ));


        }
        ).catchError((error){

        });
        await  element.reference.collection('likes').get().
        then((value) {
          likes.add(value.docs.length);


          emit(SocialGetPostSuccessState( ));


        }).
        catchError((error){/*SocialGetPostErrorState(error.toString());*/});
        postsId.add(element.id);
        postsList.add( PostModel.fromJson(element.data()));
        emit(SocialGetPostSuccessState( ));
      }) ;
    }).catchError((error) {
      print(error.toString());

      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  List<UserModel>users=[];

  Future<void> getUsers() async {
    emit(SocialLoadingState());
    if(users.isEmpty) {
      FirebaseFirestore.instance.collection('user').get().then((value) {
        for (var element in value.docs) {
          if(element.data()['id']!=userModel!.id){
            users.add(UserModel.fromJson(element.data()) );

          }
        }

        emit(SocialGetUsersSuccessState( ));
      }).catchError((error) {
        print(error.toString());

        emit(SocialGetUsersErrorState(error.toString()));
      });
    }
  }



  //todo==========================================================================

  void updateUserData({required String name,
    required String phone,

    required String bio,
  String? cover,
    String?image
  }){


    UserModel  userUpdatedModel =UserModel(email: userModel!.email,
        username: name,
        id: userModel!.id,
        phone: phone,
        profileImage: image??userModel!.profileImage,
        coverImage:cover?? userModel!.coverImage,
        bio: bio,
        isEmailVerification: userModel!.isEmailVerification);


    FirebaseFirestore.instance.collection('user').doc(userUpdatedModel.id)
        .update(userUpdatedModel.toMap())
        .then((value) {
      getData();
    })
        .catchError((error){

      emit(SocialUpdateErrorState(error.toString()));
    });
  }
//todo==========================================================================

  PostModel?  postModel;
  void createNewPost({
    String ?postImage,
   required String     postText,
   required String     dateTime,}){
    emit(SocialCreateNewPostLoadingState());
    postModel =PostModel(username: userModel!.username,
        profileImage: userModel!.profileImage,
        postImage: postImage??'',
        uId: userModel!.id,
        dateTime: dateTime,
        postText: postText);
    FirebaseFirestore.instance.collection('posts').add(postModel!.toMap()).then(
            (value) {emit(SocialCreateNewPostSuccessState(uId)) ;
        }).catchError((error){
      print(error.toString());
      emit(SocialCreateNewPostSuccessState(error.toString())) ;
    });
  }

//todo==========================================================================
  void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').
    doc(postId).
    collection('likes').
    doc(userModel!.id).set({'like':true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error){
      emit(SocialLikePostErrorState(error.toString()));
    });

  }
  void commentPost(String postId,String comment){
    FirebaseFirestore.instance.collection('posts').
    doc(postId).
    collection('comments').add( {userModel!.username :comment
     }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error){
      emit(SocialCommentPostErrorState(error.toString()));
    });

  }

  //todo ImagePicker الجزء بتاع=====================================================

  File? profileImage;
  var packer = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await packer.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialImageSuccessState());
    } else {
      print('no image to picked');
      emit(SocialImageErrorState('no image to picked'));
    }
  }


  void uploadProfileImage({required String name,
    required String phone,

    required String bio,}) {
    emit(SocialUpdateLoadingState( ));
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {

               updateUserData(name: name, phone: phone, bio: bio,image: value);

        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState(error.toString()));
      })
      ;
    }).
    catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState(error.toString()));
    })


    ;
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await packer.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverSuccessState());
    } else {
      print('no image to picked');
      emit(SocialCoverErrorState('no image to picked'));
    }
  }


  void uploadCoverImage({required String name,
    required String phone,

    required String bio,}) {
    emit(SocialUpdateLoadingState( ));
    firebase_storage.FirebaseStorage.instance.ref().
    child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
updateUserData(name: name, phone: phone, bio: bio,cover: value);
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState(error.toString()));
      })
      ;
    }).
    catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState(error.toString()));
    });
  }
  //todo==========================================================================

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await packer.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessState());
    } else {
      print('no image to picked');
      emit(SocialPostImageErrorState('no image to picked'));
    }
  }


  void uploadPostImage({required String postText,
    required String dateTime,

  }) {
    emit(SocialUploadPostImageLoadingState( ));
    firebase_storage.FirebaseStorage.instance.ref().
    child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        createNewPost(postImage: value, postText: postText, dateTime: dateTime);
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadPostImageErrorState(error.toString()));
      })
      ;
    }).
    catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState(error.toString()));
    });
  }
  //todo==========================================================================
void sendMessage({required String receiverId,required int dateTime,required String text,})  {
  MessageModel model = MessageModel(dateTime: dateTime,
      sender: userModel!.id,
      receiver: receiverId,
      text: text);
  FirebaseFirestore.instance
      .collection('user')
      .doc(userModel!.id)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .add(model.toMap())
      .then((value) {

  })
      .catchError((error) {
    emit(SocialSendMessageErrorState(error));
  });
     FirebaseFirestore.instance
      .collection('user')
      .doc(receiverId)
      .collection('chats')
      .doc(userModel!.id)
      .collection('messages')
      .add(model.toMap())
      .then((value) {
   })
      .catchError((error) {
    emit(SocialSendMessageErrorState(error));
  });

  emit(SocialSendMessageSuccessState());
}
  //todo==========================================================================
List<MessageModel>message=[];
  List< Map<String, dynamic>>data=[];
  void getMessages({required String receiverId})  {
      FirebaseFirestore.instance.collection('user')
        .doc(userModel!.id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dateTime')
        .snapshots()
        .listen((event) {

      message = [];
      data=[];
         event.docs.forEach((element){
           data.add(element.data());
         message.add(MessageModel.fromJson(element.data()));
      });


      emit(SocialGetMessageSuccessState());
    });
  }
  //todo الجزء بتاع التنقل في النفيجيتور بار
  //todo==========================================================================

  int currentindex = 0;
  List screens = [
    const FeedsScreen(),
    const ShatScreen(),
    const PostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
    // const SettingsScreen(),
  ];

  List<BottomNavigationBarItem>bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.upload_rounded), label: 'Post'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),

    //  const BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
  ];

  List<String>title = [
    'Home',
    'Shat',
    "Post",
    'Users',
    'Settings',
  ];

  //todo الجيت بتاعت الزراير المتغيرة


  void changeBottomNavBar(int index) async {
    if(index==1){
      getUsers();
      currentindex=1;
     }
    else if (index == 2) {
      emit(NewsNewPostState());
    } else {
      currentindex = index;
      emit(NewsBottomBarState());
    }
    /*   if(index==2) {
      getScience();
    }

  }
*/

  }

}
 //todo==========================================================================


