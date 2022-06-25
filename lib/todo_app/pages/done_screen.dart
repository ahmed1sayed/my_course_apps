import 'package:ahmed_new_test/todo_app/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/states.dart';
import '../consts.dart';
class DoneScreen extends StatefulWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,States>(
        builder: (context,state){var tasks=TasksCubit.get(context).doneTasks;
        if(state is GetDatabasLoadingeState) {return const Center(child: CircularProgressIndicator());

        }else{ return ListView.separated(
            itemBuilder: (context, index) => taskItem(tasks[index],context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            itemCount:tasks.length);}
        }, listener: (context,state){});

  }
}
