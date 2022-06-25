import 'package:ahmed_new_test/widgets.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/end_points.dart';
 import 'package:ahmed_new_test/shope_app/shope_logic/home_cubit/home_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shope_logic/home_cubit/home_cubit.dart';
import '../../shope_logic/home_cubit/home_model.dart';
 class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: BlocConsumer<HomeCubit,HomeState>(
        listener: (context,state){

      if(state is ChangeFavorSuccessState){
        if(state.model!.status) {
          Fluttertoast.showToast(
              msg: state.model!.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.black,
              fontSize: 16.0
          );
        }
      }

       },builder: (context,state){
      //int productsLength= HomeCubit.get(context).shopModel!.data.products.length ;
    return
      HomeCubit.get(context).shopModel != null && HomeCubit.get(context).categoryModel !=null?
      SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CarouselSlider(
                items:  HomeCubit.get(context).shopModel!.data.banners.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(

                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration:   BoxDecoration(
                              color: Colors.blueGrey,
                            image: DecorationImage(
                                image: NetworkImage(i.image),
                                fit: BoxFit.cover
                            ),
                          ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )
            ),
          ),
const Text('Categories',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800 ),),/*HomeCubit.get(context).categoryModel!=null?*/
          const SizedBox(height: 10,),

          SizedBox(height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=>categoryItems(index: index),
                separatorBuilder:   (context,index)=>const SizedBox(width: 10,),
                itemCount:  HomeCubit.get(context).categoryModel!.data.data.length),
          ),
          const SizedBox(height: 20,),
          const Text('Products',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800 ),),
          const SizedBox(height: 10,),

          Container(
            //padding: const EdgeInsets.only(top: 1),
            color: Colors.grey,
            child:  GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              crossAxisCount:2,
childAspectRatio: 1/1.23,

shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
              children: List.generate( HomeCubit.get(context).shopModel!.data.products.length,
                      (index) => buildProductsItem(index: index,
                          model:  HomeCubit.get(context).shopModel!,
                          context: context)),

          ),

          )
  ],),
      ):

        Center(child: CircularProgressIndicator(color: defaultColor,));

      }
      ,),
    );
  }
  Widget categoryItems({required int index})=>
  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:    [
  Image(image: NetworkImage(HomeCubit.get(context).categoryModel!.data.data[index].image),
  fit: BoxFit.cover,width: 100,height: 100,),
    Container(
      height: 20,
        width: 100,
        color: Colors.black26,
        child: Center(child:  Text(
          HomeCubit.get(context).categoryModel!.data.data[index].name,
          style:const TextStyle(
              fontSize: 11,
              fontWeight:FontWeight.bold,
              color: Colors.white),overflow: TextOverflow.ellipsis, maxLines: 1,)))

  ],);
  Widget buildProductsItem({required int index, required ShopModel model,required context, }) {

    double appWidth = MediaQuery
        .of(context)
        .size
        .width;
    return /*InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(

          builder: (context)=>article['url']!=null?
          WebViewScreen(url: article['url']):const CircleAvatar()));
    },
    child:*/ Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [          const SizedBox(height: 5),

          model.data.products[index].image !=null? Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                height: appWidth * .33,
                width:  appWidth * .33,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(model.data.products[index].image),
                    //  fit: BoxFit.cover
                  ),
                  //   borderRadius: BorderRadius.circular(10)
                ),
              ),     if (model.data.products[index].discount!=0)
                Container(color: Colors.red,
                  height: 14,
                  width: 57,
                  child:const Center(child:  Text('DISCOUNT',style: TextStyle(fontSize: 10,fontWeight:FontWeight.bold, color: Colors.white), )),)
            ],
          ) : Container(
            height: appWidth * .33,
            width:  appWidth * .33,
            child: const Center(child: Text('not found')),
            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10)
            ),
          ),
          const SizedBox(height: 20,),

          Expanded(

            child: Padding(
              padding: const EdgeInsets.only(left: 7.0,right: 7),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.data.products[index].name,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    // ,maxLines: 4,overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5,),
                  Row(//mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(model.data.products[index].price.toString(),
                        style:TextStyle(color:defaultColor,fontSize: 16),),
                      const SizedBox(width: 10,),
                      if(  model.data.products[index].discount!=0)
                        Text(model.data.products[index].oldPrice.toString(),
                          style:const TextStyle(color:Colors.grey,fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ) ,
                      const Spacer(),
                      CircleAvatar(

                          backgroundColor:HomeCubit.get(context).favor[HomeCubit.get(context).shopModel!.data.products[index].id]!?defaultColor:Colors.grey ,
                          child: IconButton(onPressed: (){
                            HomeCubit.get(context).getChangeFavorData(productId: model.data.products[index].id);
                          }, icon: const Icon(Icons.favorite_border)))

                    ],
                  ),

                ],),
            ),
          )
        ],),
    );
  }
}
/*  HomeCubit.get(context).shopModel != null?
ListView.separated(
itemBuilder: (context,index){
return buildProductsItem(
index: index,
model:  HomeCubit.get(context).shopModel!,
context: context);
},
separatorBuilder:(context,index){
return const Divider( color: Colors.grey,height:20 ,);
},
itemCount:HomeCubit.get(context).shopModel!.data.products.length ):
const Center(child: CircularProgressIndicator(color: Colors.orange,)),*/
