
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/app_cubit.dart';
import '../logic/app_states.dart';
import '../../widgets.dart';
class SearchScreen extends StatefulWidget {
   const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery
        .of(context)
        .size
        .width;
    var list = AppCubit
        .get(context)
        .search;
    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(padding: const EdgeInsets.all(20),
              child: TextFormField(
                onChanged: (val) {
                 // AppCubit.get(context).getSearch(value: val);
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
            Expanded(child: list.isEmpty ?
             Center(
                child: Container()
            ) :
            ListView.separated(itemBuilder: (context, index) {
              return buildArticleItem(
                  h: appWidth * .33, article: list[index], context: context);
            },
                separatorBuilder: (context, index) {
                  return const Divider(height: 1, color: Colors.grey,);
                },
                itemCount: list.length)
            )

          ],),
        );
      },
    );
  }
}
