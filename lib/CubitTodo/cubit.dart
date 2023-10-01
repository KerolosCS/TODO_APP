/*
 *
 * ----------------
 * | 241030072002 |
 * ----------------
 * Copyright © [2023] KERO CS FLUTTER DEVELOPMENT.
 * All Rights Reserved. For inquiries or permissions, contact  me ,
 * https://www.linkedin.com/in/kerolos-fady-software-engineer/
 *
 * /
 */

// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/CubitTodo/states.dart';

import '../modules/archived_task.dart';
import '../modules/done_task.dart';
import '../modules/new_task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndexVar = 0;
  List<Widget> screens = const [
    NewTaskScreen(),
    DoneTaskSreen(),
    ArchivedTaskScreen(),
  ];
  List<Text> titles = const [
    Text("New Task"),
    Text("Done Tasks"),
    Text("Archived Tasks"),
  ];
  late Database database;
  List<Map> newTasksList = [];
  List<Map> doneTasksList = [];
  List<Map> archivedTasksList = [];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print("Database created");
        db
            .execute(
          'CREATE TABLE tasks (id integer primary key, title text, date text ,time text, status text)',
        )
            .then(
          (value) {
            print("Table created");
          },
        ).catchError((e) {
          print("Error : ${e.toString()}");
        });
      },
      onOpen: (db) {
        print("Database opened");
        getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

//future
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'insert into tasks (title , date , time, status) values("$title","$date","$time","new")')
          .then(
        (value) {
          print("$value Row added succesfully");
          emit(AppInsertDatabaseState());
          getDataFromDatabase(database);
        },
      ).catchError(
        (e) {
          print("Error while adding row !!");
        },
      );
    });
  }

  void getDataFromDatabase(db) {
    newTasksList = [];
    doneTasksList = [];
    archivedTasksList = [];
    emit(AppGetDatabaseLoadingState());
    db.rawQuery('SELECT * from tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasksList.add(element);
        } else if (element['status'] == 'done') {
          doneTasksList.add(element);
        } else if (element['status'] == 'archive') {
          archivedTasksList.add(element);
        }
      });
      // getDataFromDatabase(db);
      emit(AppGetFromDatabaseState());
    });
  }

  updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [
        status,
        '$id',
      ],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  deleteData({required int id}) {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      ["$id"],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeIndex(int index) {
    currentIndexVar = index;
    emit(AppChangeBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
