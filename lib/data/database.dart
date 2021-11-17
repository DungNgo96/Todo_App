import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_app/data/states.dart';
import 'package:todo_app/presentation/pages/sub_homepage/all_tasks.dart';
import 'package:todo_app/presentation/pages/sub_homepage/done_tasks.dart';
import 'package:todo_app/presentation/pages/sub_homepage/undone_taks.dart';

class AppDataBase extends Cubit<AppStates> {
  AppDataBase() : super(AppInitialState());

  static AppDataBase get(context) => BlocProvider.of(context);

  int navigationIndex = 0;
  List<Map> allTasks = [];
  List<Map> doneTasks = [];
  List<Map> undoneTasks = [];

  List<Widget> screens = const [AllTasks(), DoneTasks(), UndoneTasks()];

  Database? database;

  void changeIndex(int index) {
    navigationIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void updateDB(String status, int id) async {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDB(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDB(int id) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDB(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void createDB() {
    openDatabase(
      "todo_app.db",
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) => null)
            .catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (db) {
        getDB(db);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getDB(db) async {
    allTasks = [];
    doneTasks = [];
    undoneTasks = [];
    db!.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((item) {
        if (item["status"] == "Undone") {
          undoneTasks.add(item);
        }
        if (item["status"] == "Done") {
          doneTasks.add(item);
        }
        allTasks.add(item);
      });
      emit(AppGetDatabaseState());
    });
  }

  insertToDB(
      {required String title,
      required String time,
      required String date}) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES ("$title","$date","$time","Undone")')
          .then((value) {
        getDB(database);
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
      }).catchError((error) {
        print('Error When inserting Table ${error.toString()}');
      });
    });
  }
}
