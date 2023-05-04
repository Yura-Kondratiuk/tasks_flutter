import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_flutter/models/task.dart';

class DatabaseHelper {

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDetail = 'detail';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDetail TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertTask(Task task) async {
    Database db = await database;
    var result = await db.insert(noteTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    var db = await database;
    var result = await db.update(noteTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    var db = await database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    var noteMapList = await getTaskMapList();
    int count = noteMapList.length;

    List<Task> noteList = <Task>[];

    for (int i = 0; i < count; i++) {
      noteList.add(Task.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
