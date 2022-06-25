import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../logic/app_cubit.dart';
import '../logic/app_states.dart';
import '../../widgets.dart';

class BisnessScreen extends StatefulWidget {
  const BisnessScreen({Key? key}) : super(key: key);

  @override
  _BisnessScreenState createState() => _BisnessScreenState();
}

class _BisnessScreenState extends State<BisnessScreen> {
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
          .business;
    return  ScreenTypeLayout(
        mobile:list.isEmpty?
          const Center(
            child: CircularProgressIndicator()
        ):

      ListView.separated(itemBuilder: (context, index) {
      return buildArticleItem(h: appWidth * .33, article: list[index],context: context);
      },
      separatorBuilder: (context, index) {
      return const Divider(height: 1, color: Colors.grey,);
      },
      itemCount: list.length),


        desktop:const Text('Desk Top',style: TextStyle(fontSize: 50),) ,
        breakpoints: const ScreenBreakpoints(desktop: 600,tablet: 300,watch: 300),
      ) ;

    }, listener: (context, state) {},);
  }
}
