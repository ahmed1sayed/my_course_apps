import 'package:ahmed_new_test/social_app/social_logic/social_cubit/post_model.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_cubit.dart';
import 'package:ahmed_new_test/social_app/social_logic/social_cubit/social_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatefulWidget {

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
/*
  List<int>indexes=[];
  List<TextEditingController> commentControllers =[];
*/

  TextEditingController dd=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(builder: (context, state) {
      return SocialCubit
          .get(context)
          .postsList
          .isNotEmpty && SocialCubit.get(context).userModel !=null   ?
      Scaffold(
        body: SingleChildScrollView(

          child: Column(children: [

            const Card(
              elevation: 5,
              child: Image(image:
              NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlDzUWj5svIi94MEs3S0hBSlFo1vwxeC42vw&usqp=CAU'),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10,),
             ListView.separated(
                itemBuilder: (context, index) {
                 /* indexes.add(index);
                      for (var element in indexes) {
                        commentControllers.add(TextEditingController());
                      }*/
                  return buildPostItem(
                      SocialCubit
                          .get(context)
                          .postsList[index],
                      context,
                      index,/*commentControllers[index]*/);
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 7,),

                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: SocialCubit
                    .get(context)
                    .postsList
                    .length )

          ],),
        ),

      ) : const Center(child: Text('Loading...'));
    }, listener: (context, state) {});
  }

  Widget buildPostItem(PostModel model,context,int index ,/*TextEditingController comment*/) {

    return Card(
      elevation: 5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

                Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(

                  backgroundImage: NetworkImage(

                     model.profileImage),
                  backgroundColor: Colors.black12,
                  radius: 30,

                ),
              ),
              const SizedBox(height: 10,),
              Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.username, style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 17),),
                  const SizedBox(height: 5,),
                    Text(model.dateTime, style:const TextStyle(
                      fontSize: 13, color: Colors.black45),),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz))


            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    model.postText,
                    style:const TextStyle(),
                    textScaleFactor: 1.15,

                  ),
                ),
                if(model.postImage!='')
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                      image:   DecorationImage(image: NetworkImage(
                          model.postImage),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(4)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(elevation: 0,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                            primary: Colors.black,)
                          , onPressed: () {/*
                    SocialCubit.get(context).likePost(model.uId);
*/
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);},
                          icon: const Icon(
                            Icons.favorite_border, color: Colors.red,
                            size: 20,),
                          label:   Text(SocialCubit.get(context).likes[index].toString(), style:const TextStyle(
                              color: Colors.black87, fontSize: 14),),)

                        ,

                        const Spacer(),
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 7),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            primary: Colors.black,)
                          , onPressed: () {},
                          icon: const Icon(Icons.message_outlined,
                              color: Colors.black54, size: 20),
                          label:  Text(SocialCubit.get(context).comments[index].toString(),
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 13),),)


                      ],
                    ),
                  ),
                ),
              ],),
          ),
          const Divider(color: Colors.black45, indent: 2, endIndent: 2,),

          Padding(
            padding: const EdgeInsets.only(
                left: 5, right: 5, bottom: 5.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20,)
              )
              ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                    Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 7),
                    child: CircleAvatar(

                      backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.profileImage /* model.profileImage*/),
                      backgroundColor: Colors.black12,
                      radius: 20,

                    ),
                  ),
                   Expanded(

                     child: TextFormField(
                      controller: dd/*comment*/,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a comment...',
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.black45),
                      ),
                  ),
                   ),
                   IconButton(onPressed: () {

                     SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index],dd.text/*comment.text*/);
                     dd.clear();
                     // commentControllers.clear();
/*
                     print(commentControllers.toString());
*/
                  }, icon: const Icon(
                    Icons.arrow_forward_ios, color: Colors.blue,)),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
