import 'package:ahmed_new_test/todo_app/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../pages/archived_screen.dart';
import '../pages/done_screen.dart';
import '../pages/tasks_screen.dart';

class TasksCubit extends Cubit<States> {
  late Database database;
  List <Map>newTasks = [];
  List <Map>archivedTasks = [];
  List <Map>doneTasks = [];

  TasksCubit() :super(GetDatabasLoadingeState());

  static TasksCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List screen = [const TaskScreen(), const DoneScreen(), const ArchivedScreen()];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNaBaState());
  }

  void createDatabase() async {
    database = await openDatabase('tasks.db',
      version: 1,
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE TASKS(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table has created');
        }
        )
            .catchError((error) {
          print('error is :${error.toString()}');
        });
        print('database has created');
      }, onOpen: (database) {
        getDatabase(database);
        print('database has opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
      return database;
    });
  }

  insertDatabase({
    required String title,
    required String date,
    required String time
  }) async {
    await database.transaction(
            (txn) => txn.rawInsert(
            'INSERT INTO TASKS(title,date,time,status)VALUES("$title","$date","$time","status")')
    ).then((value) {
      print('$value inserted successfully');
      emit(InsertDatabaseState());
      getDatabase(database);
    }
    ).catchError((e) {
      print('insert error is : ${e.toString()}');
    });
  }

  void getDatabase(database) {
    //* sign mains (all of) ..#
    newTasks = [];
    archivedTasks = [];
    doneTasks = [];
    emit(GetDatabasLoadingeState());
    database.rawQuery('SELECT * FROM TASKS').then((value) {
      value.forEach((element) {
        if (element['status'] == 'status') {
          newTasks.add(element);
        }
        else if (element['status'] == 'done') {
          doneTasks.add(element);
        }
        else {
          archivedTasks.add(element);
        }
      });
      emit(GetDatabaseState());
    });
  }

  Icon fIcon = const Icon(Icons.edit);
  bool isBottomSheet = false;

  void changeButton({required bool isShow, required Icon icon}) {
    isBottomSheet = isShow;
    fIcon = icon;
    emit(ChangeBottomSheetState());
  }

  void updateDatabase({required String status, required int id}) async {
    await database.rawUpdate(
        'UPDATE TASKS SET status = ? WHERE id=?', [status, id,]).then((
        value) {
      getDatabase(database);
      emit(UpdateDatabaseState());
    });
  }
  void deleteDatabase({required int id}){
    database.rawDelete('DELETE FROM TASKS WHERE id=?', [id]).then((
        value) {
      getDatabase(database);
      emit(DeleteDatabaseState());
    });
  }
}

