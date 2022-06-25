import 'package:ahmed_new_test/news_app/logic/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/app_states.dart';
import '../../widgets.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  @override
  Widget build(BuildContext context) {
    // double appHigh=MediaQuery.of(context).size.height;
    double appWidth = MediaQuery
        .of(context)
        .size
        .width;

    // ignore: non_constant_identifier_names
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      var list = AppCubit
          .get(context)
          .science;
      if (list.isEmpty) {

        return const Center(
            child: CircularProgressIndicator(),

        );
      } else {
        return ListView.separated(itemBuilder: (context, index) {
          return buildArticleItem(h: appWidth * .33, article: list[index],context: context);
        },
            separatorBuilder: (context, index) {
              return const Divider(height: 1, color: Colors.grey,);
            },
            itemCount: list.length);
      }
    }, listener: (context, state) {},);
  }
}
