
import 'package:ahmed_new_test/shope_app/shope_logic/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shope_logic/home_cubit/home_cubit.dart';
import '../../shope_logic/home_cubit/home_states.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<HomeCubit,HomeState>(listener: (context,state){},builder: (context,state){
         return
       /*   HomeCubit.get(context).categoryModel !=null?*/
          ListView.separated(
               itemBuilder: (context,index)=>categoryScreenItem(index: index),
              separatorBuilder:   (context,index)=>const SizedBox(width: 10,),
              itemCount:  HomeCubit.get(context).categoryModel!.data.data.length)/*:
             Center(child: CircularProgressIndicator(color:defaultColor,))*/;
      }
        ,),

    );
  } Widget categoryScreenItem({required int index})=>
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
           children:    [
            Image(image: NetworkImage(HomeCubit.get(context).categoryModel!.data.data[index].image),
              fit: BoxFit.cover,width: 100,height: 100,),
            Padding(
padding:const EdgeInsets.only(left: 20),

                child: Center(child:  Text(
                  HomeCubit.get(context).categoryModel!.data.data[index].name,
                  style:const TextStyle(
                      fontSize: 20,
                      fontWeight:FontWeight.bold,
                      color: Colors.black),overflow: TextOverflow.ellipsis, maxLines: 1,))),
            const Spacer(),
             IconButton(onPressed: ( ){}, icon:const Icon(Icons.arrow_forward_ios))


          ],),
      );
}
