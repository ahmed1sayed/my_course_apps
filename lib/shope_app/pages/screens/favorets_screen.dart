import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shope_logic/end_points.dart';
import '../../shope_logic/home_cubit/home_cubit.dart';
import '../../shope_logic/home_cubit/home_states.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocConsumer<HomeCubit,HomeState>(listener: (context,state){},builder: (context,state){
        return
     state is! FavoriteLoadingState?
          ListView.separated(
              itemBuilder: (context,index)=>categoryScreenItem(index: index),
              separatorBuilder:   (context,index)=>const Divider(color: Colors.black12,),
              itemCount:  HomeCubit.get(context).favoriteModel!.data!.data .length):
             Center(child: CircularProgressIndicator(color:defaultColor,));
      }
        ,),

    );
  } Widget categoryScreenItem({required int index})=>
      Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children:    [
            Image(image: NetworkImage(HomeCubit.get(context).favoriteModel!.data!.data[index].product.image),
             width: 90,height: 90,),
            Padding(
                padding:const EdgeInsets.only(left: 10),

                child: Center(child:  SizedBox(
                  width: 200,
                  child: Text(
                    HomeCubit.get(context).favoriteModel!.data!.data[index].product.name,
                    style:const TextStyle(
                        fontSize: 15,
                        fontWeight:FontWeight.bold,
                        color: Colors.black),overflow: TextOverflow.ellipsis, maxLines: 2,),
                ))),
            const Spacer(),
               CircleAvatar(

  backgroundColor:HomeCubit.get(context).favor[HomeCubit.get(context).favoriteModel!.data!.data[index].product .id]!?defaultColor:Colors.grey ,
  child: IconButton(onPressed: (){
  HomeCubit.get(context).getChangeFavorData(productId: HomeCubit.get(context).favoriteModel!.data!.data[index].product.id);
  }, icon: const Icon(Icons.favorite_border)
  )
               )



  ],),
      );
}
