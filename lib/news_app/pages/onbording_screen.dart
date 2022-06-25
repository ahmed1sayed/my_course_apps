import 'package:ahmed_new_test/news_app/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shope_app/pages/logging/login_screen.dart';
import '../../widgets.dart';
 class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardindController=PageController();
  bool isLast=false;
  void submit(){
    CacheHelper.saveData(key:'onBoarding' ,value:true ).then((value) {
  if(value == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen() /*const Home()*/,
            ), (route) {
          return false;
        });
      }
    });
  }
  List<BoardingModel>boarding=[
    BoardingModel('assets/imgs/undraw_Online_article_re_daq5.png', 'title1', 'body1'),
    BoardingModel('assets/imgs/undraw_Sharing_articles_re_jnkp.png', 'title2', 'body2'),
    BoardingModel('assets/imgs/undraw_The_world_is_mine_re_j5cr.png', 'title3', 'body3'),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(leading: Container(),backgroundColor: Colors.transparent,
           elevation: 0,
       actions: [customTextButton(text: 'SKIP',onPressed: (){submit();})],),

      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Expanded(child:
          PageView.builder(itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
            itemCount: boarding.length,
            controller: boardindController,
            onPageChanged: (int index){
            if(index==boarding.length-1){
              setState(() {
                isLast=true;
              });
            }else{

              setState(() {
                isLast=false;
              });
            }            },
            physics:const BouncingScrollPhysics() ,
          )),
          Row(children: [
           SmoothPageIndicator(controller: boardindController, count:  boarding.length,effect: const ExpandingDotsEffect(
             dotColor: Colors.grey,
             activeDotColor: Colors.deepOrange,
             dotHeight: 10,
             expansionFactor: 4,
             dotWidth: 10,
             spacing: 5,

           ),),
            const Spacer(flex: 1,),
            FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                child: const Icon(Icons.arrow_forward_ios),
                onPressed: ( ){

            if(isLast){
              submit();
            }else{
              boardindController.nextPage(duration:const Duration(milliseconds: 600) , curve: Curves.easeIn);
            }


            })
          ],),
        ],),
      ),
    );
  }

  buildBoardingItem(BoardingModel boarding) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Image(image: AssetImage(boarding.image), ),
        const SizedBox(height: 100,),
           Text(boarding.title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
        Text(boarding.body)

      ]
  );
}
class BoardingModel{
  String image;
  String title;
  String body;

  BoardingModel(this.image, this.title, this.body);
}