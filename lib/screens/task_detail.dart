import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_flutter/models/task.dart';
import 'package:tasks_flutter/utils/database_helper.dart';

class TaskDetail extends StatefulWidget {
  final String appBarTitle;
  final Task task;

  const TaskDetail(this.task, this.appBarTitle, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TaskDetailState(task, appBarTitle);
  }
}

class TaskDetailState extends State<TaskDetail> {
  static final _priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Task task;

  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  TaskDetailState(this.task, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;
    detailController.text = task.detail;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
          return Future(() => false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
              onPressed: () {
                moveToLastScreen();
              },
              icon: const Icon(Icons.transit_enterexit_rounded),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                    items: _priorities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    value: getPriorityAsString(task.priority),
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updatePriorityAsInt(valueSelectedByUser!);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      debugPrint(' Text_field Task some changed ');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    controller: detailController,
                    onChanged: (value) {
                      debugPrint(' Text_field Detail some changed ');
                      updateDetail();
                    },
                    decoration: InputDecoration(
                        labelText: 'Details',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.cyan),
                          onPressed: () {
                            setState(() {
                              debugPrint('Save clicked');
                              _save();
                            });
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10, height: 2),
                      Expanded(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint('Delete clicked');
                                _delete();
                              });
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        task.priority = 1;
        break;
      case 'Low':
        task.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority = '';
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    task.title = titleController.text;
  }

  void updateDetail() {
    task.detail = detailController.text;
  }

  void _save() async {
    moveToLastScreen();
    task.date = DateFormat.yMMMd().add_Hms().format(DateTime.now());

    int result;
    if (task.id != null) {
      result = await helper.updateTask(task);
    } else {
      result = await helper.insertTask(task);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Task saved');
    } else {
      _showAlertDialog('Status', 'Problem saved Task');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (task.id == null) {
      _showAlertDialog('Status', 'No Task was deleted');
      return;
    }
    int result = await helper.deleteTask(task.id!);
    if (result != 0) {
      _showAlertDialog('Status', 'Task delete');
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Task');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
