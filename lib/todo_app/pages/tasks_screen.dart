import 'package:ahmed_new_test/todo_app/bloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/states.dart';
import '../consts.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
   const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,States>(
        builder: (context,state){var tasks=TasksCubit.get(context).newTasks;
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
