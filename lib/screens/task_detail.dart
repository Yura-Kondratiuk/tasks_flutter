import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  String appBarTitle;

  TaskDetail(this.appBarTitle, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TaskDetailState(appBarTitle);
  }
}

class TaskDetailState extends State<TaskDetail> {
  static final _priorities = ['High', 'Low'];

  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  TaskDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
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
                    value: 'Low',
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) {
                      debugPrint(' Text field some changed ');
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
                    controller: detailsController,
                    onChanged: (value) {
                      debugPrint(' Text field some changed ');
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
    Navigator.pop(context);
  }
}
