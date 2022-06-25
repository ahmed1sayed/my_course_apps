

import 'package:ahmed_new_test/news_app/web_view/web_view.dart';
 import 'package:flutter/material.dart';




Widget buildArticleItem({required double h,required article,required context}) {
  return InkWell(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(

           builder: (context)=>article['url']!=null?
                  WebViewScreen(url: article['url']):const CircleAvatar()));
     },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          article['urlToImage']!=null?   Container(
            height:h,
            width: h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(10)
            ),
          ): Container(
            height:h,
            width: h,
            child: const Center(child: Text('not found')),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)
            ),
          ),const SizedBox(width: 10,),
          Expanded(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  // ,maxLines: 4,overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10,),
                Text('${article['publishedAt']}',
                  style: Theme.of(context).textTheme.bodyText1,),

              ],),
          )
        ],),
    ),
  );
}
void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));

Padding defaultFormField({required controller,

  required TextInputType type,
  String? Function(String?)? validate,
  required String  label,
    IconData ? prefix,
  IconData ? suffix,
bool scure = false,
   void Function()?IconOnPressed,
}){
  return  Padding(
    padding:  const EdgeInsets.all(15),
    child: TextFormField(

      keyboardType: type,
      controller: controller,
      validator: validate,
        obscureText: scure,
      decoration:   InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        labelText:label,
        prefixIcon:Icon(prefix),
        suffixIcon: IconButton(icon:  Icon(suffix),onPressed: IconOnPressed
        ),


      ),


    ),

  );
}

Widget CustomButton({required void Function()? onTap,required String title,double? width,double? height, double? fontSize }){
 return Center(
   child: Padding(
     padding:const EdgeInsets.only(top: 5),

      child: SizedBox(
       height:height?? 40,
       width:width?? 367,
       child: ElevatedButton(

         onPressed:onTap,
         child:   Text(title, style: TextStyle( fontSize:fontSize?? 22,fontWeight: FontWeight.bold),),
       ),
     ),
   ),
 );
 }

Widget RegisterTxtButton({required void Function()? onPressed}){return
  Padding(
    padding: const EdgeInsets.only(left: 12),
    child: Row(
      children:  [
        const Text('if you don\'t have an account ?',style: TextStyle(
            color: Colors.black54,
            fontSize: 16),),  TextButton(onPressed:onPressed , child: const Text('click here',style: TextStyle(
            // ignore: use_full_hex_values_for_flutter_colors
            color:Color(0xFFFF44A3C4),
            fontSize: 16),),)
      ],
    ),
  );
}


Widget customTextButton({required void Function()? onPressed,required String text}){

  return
    Padding(
      padding: const EdgeInsets.all( 12),
      child: TextButton(onPressed:onPressed , child:   Text(text,style: const TextStyle(
       // ignore: use_full_hex_values_for_flutter_colors
         color:Color(0xFFFF44A3C4),
         fontSize: 20),),),
    );
}
void normalNavigate(
    {required context,
      required method}){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>method));

}

void navigateAndFinish(
{required context,
  required method}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context)=>method /*const Home()*/,
      ), (route) {
    return false;
  });
}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');//800 is the size of each chunk
  pattern.allMatches(text).forEach((element) =>print(element.group(0)));
}
PreferredSizeWidget? postAppbar({required String title,required BuildContext context,
   required void Function()? actionOnPressed,
  required String actionTitle
})=>AppBar(title: Text(title),
  leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
    onPressed: (){Navigator.pop(context);
    },),
actions: [   Padding(
    padding: const EdgeInsets.all( 12),
child: TextButton(onPressed:  actionOnPressed, child:   Text(actionTitle,style: const TextStyle(
// ignore: use_full_hex_values_for_flutter_colors
color:Color(0xFFFF44A3C4),
fontSize: 20),),),
),],
);
