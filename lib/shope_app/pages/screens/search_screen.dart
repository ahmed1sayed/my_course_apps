import 'package:ahmed_new_test/shope_app/shope_logic/end_points.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/search_cubit/search_cubit.dart';
import 'package:ahmed_new_test/shope_app/shope_logic/search_cubit/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

 TextEditingController searchController=TextEditingController();
 var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(builder:(context,state){
      return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(children: [
              Padding(padding: const EdgeInsets.all(20),
                child: TextFormField(
                  onFieldSubmitted: (val) {
                    SearchCubit.get(context).getSearch(text: val);
                  },
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      label: Text('Search'),
                      prefix: Icon(Icons.search)
                  ),
                ),
              ),
              Expanded(child: state is SearchSuccessState? ListView.separated(
                  itemBuilder: (context,index)=>categoryScreenItem(index: index),
                  separatorBuilder:  (context,index)=>const Divider(color: Colors.black12,),
                  itemCount: SearchCubit.get(context).searchModel!.data.data.length
              ):Center(
                child: CircularProgressIndicator(color: defaultColor,),))

            ]
            ),
          )
      );
    }, listener: (context,state){});
  }Widget categoryScreenItem({required int index})=>
     Padding(
       padding: const EdgeInsets.all(15),
       child: Row(
         children:    [
           Image(image: NetworkImage(SearchCubit.get(context). searchModel!.data.data[index].image),
             width: 90,height: 90,),
           Padding(
               padding:const EdgeInsets.only(left: 10),

               child: Center(child:  SizedBox(
                 width: 200,
                 child: Text(
                   SearchCubit.get(context).searchModel!.data.data [index] .name,
                   style:const TextStyle(
                       fontSize: 15,
                       fontWeight:FontWeight.bold,
                       color: Colors.black),overflow: TextOverflow.ellipsis, maxLines: 2,),
               ))),
           const Spacer(),
           const Icon(Icons.favorite_border)
          /* CircleAvatar(

               backgroundColor:SearchCubit.get(context).favor[HomeCubit.get(context).favoriteModel!.data!.data[index].product .id]!?defaultColor:Colors.grey ,
               child: IconButton(onPressed: (){
                 SearchCubit.get(context).getChangeFavorData(productId: HomeCubit.get(context).favoriteModel!.data!.data[index].product.id);
               }, icon: const Icon(Icons.favorite_border)
               )
           )*/



         ],),
     );
}
