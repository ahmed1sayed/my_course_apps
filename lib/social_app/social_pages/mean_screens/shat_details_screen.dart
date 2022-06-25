


import 'package:ahmed_new_test/social_app/social_logic/login_cubit/user_model.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/shat_message_model.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
  import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

class ShatDetailsScreen extends StatelessWidget {
  final UserModel userModel;
  var messageTextController = TextEditingController();

  ShatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        titleSpacing: 0,

        title: Row(

          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            CircleAvatar(

              backgroundImage: NetworkImage(
                  userModel.profileImage
                /* model.profileImage*/),
              backgroundColor: Colors.black12,
              radius: 20,

            ),
            const SizedBox(width: 10,),
            Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userModel.username /*model.username*/,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 17),),
                const SizedBox(height: 5,),

              ],
            ),

          ],
        ),
      ),
      body: Builder(
          builder: (context) {
             SocialCubit.get(context).getMessages(receiverId: userModel.id);
            return BlocConsumer<SocialCubit, SocialState>(
                builder: (context, state) {
                  return
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: [
                            Expanded(
                                child: SocialCubit
                                    .get(context)
                                    .message
                                    .isNotEmpty ? ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var message = SocialCubit
                                          .get(context)
                                          .message[index];
                                      if (SocialCubit
                                          .get(context)
                                          .userModel!
                                          .id == message.sender) {
                                        return buildMyMessage(message);
                                      } else {
                                        return buildMessage(message);
                                      }
                                    },
                                    separatorBuilder: (context, index) {
                                     return const SizedBox(height: 15,);
                                    },
                                    itemCount:  SocialCubit
                                        .get(context)
                                        .message.length): const Center(child: CircularProgressIndicator()),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black38, width: .2),

                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  children: [Expanded(
                                    child: TextFormField(
                                      controller: messageTextController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type your message here ...'
                                      ),
                                    ),

                                  ),
                                    MaterialButton(color: Colors.blueGrey,
                                        height: 45,
                                        minWidth: 50,
                                        child: const Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          size: 20, color: Colors.white,),
                                        onPressed: () {
                                           SocialCubit.get(context).sendMessage(
                                              receiverId: userModel.id,
                                              dateTime: DateTime.now().millisecondsSinceEpoch ,
                                              text: messageTextController.text);
                                        })
                                  ],
                                ),

                              ),
                            ]
                        ),
                      )
                    ;
                }, listener: (context, state) {});
          }
      ),
    );
  }

  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )
          ),
          child:   Center(child: Text(model.text)),
        ),);

  Widget
  buildMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )
          ),
          child:   Center(child: Text(model.text)),
        ),);

}
