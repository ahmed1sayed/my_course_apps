import 'package:ahmed_new_test/todo_app/bloc/cubit.dart';
import 'package:ahmed_new_test/todo_app/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../consts.dart';
class ArchivedScreen extends StatefulWidget {
  const ArchivedScreen({Key? key}) : super(key: key);

  @override
  _ArchivedScreenState createState() => _ArchivedScreenState();
}

class _ArchivedScreenState extends State<ArchivedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,States>(
        builder: (context,state){var tasks=TasksCubit.get(context).archivedTasks;
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
