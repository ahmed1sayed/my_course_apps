 import 'package:flutter/material.dart';

import 'bloc/cubit.dart';

Widget taskItem(Map model,context){
  return Dismissible(
    onDismissed: (direction){
      TasksCubit.get(context).deleteDatabase(id: model['id']);
    },
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(model['time']),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(model['title']),
                Text(model['date'],style: const TextStyle(color: Colors.grey),),
              ],),
          ),
          const SizedBox(width: 20,),
          IconButton(onPressed: (){TasksCubit.get(context).updateDatabase(status: "done", id: model['id']);}, icon:const Icon(Icons.check_box,color: Colors.green,)),
          IconButton(onPressed: (){TasksCubit.get(context).updateDatabase(status: "archive", id: model['id']);}, icon:const Icon(Icons.archive,color: Colors.black38,)),
        ],
      ),
    ),
  );
}




