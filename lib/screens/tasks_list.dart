import 'package:flutter/material.dart';
import 'package:tasks_flutter/screens/task_detail.dart';
import 'package:tasks_flutter/models/task.dart';
import 'package:tasks_flutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class TasksList extends StatefulWidget {
   const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> taskList = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {

   if (taskList == null)  {
     taskList = <Task>[];
     updateListView();
   }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint(' FAB clicked');
          navigateToDetail(Task.withoutId('','',2,''),'Add task');
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add_task_sharp),
      ),
    );
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.yellow[200],
          elevation: 2.0,
          child: ListTile(
            leading:  CircleAvatar(
              backgroundColor: getPriorityColor(taskList[position].priority),
              child: getPriorityIcon(taskList[position].priority),
            ),
            title:  Text(taskList[position].title),
            subtitle:  Text(taskList[position].date),
            trailing:GestureDetector(
              onTap: () {
                _delete(taskList[position]);
              },
              child:  const Icon(
                Icons.delete,
                color: Colors.blueGrey,
              ),
            ),
            onTap: () {
              debugPrint('List tapped');
              navigateToDetail(taskList[position],'Edit task');
            },
          ),
        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return const Icon(Icons.play_arrow);
      case 2:
        return const Icon(Icons.keyboard_arrow_right);
      default:
        return const Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(Task task) async {
    int result = await databaseHelper.deleteTask(task.id!);
    if (result != 0) {
      _showSnackBar('Task deleted successfully');
      updateListView();
    }
  }
  void _showSnackBar (String message ) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  void navigateToDetail(Task task,String title) async {
  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskDetail(task ,title);
    }));
  if (result == true) {
    updateListView();
  }
  }
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        setState(() {
          this.taskList =taskList;
          count = taskList.length;
        });
      });
    } );
  }
}
