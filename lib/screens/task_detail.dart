import 'package:flutter/material.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  static var _priorities = ['Hight', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO delete
    //TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit task'),
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
                //TODO don`t work , fix it
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
                //TODO don`t work , fix it
                 controller: detailsController,
                 onChanged: (value){ debugPrint(' Text field some changed '); },
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
                      child: const Text('Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10, height: 2),
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.cyan, //<-- SEE HERE
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint('Delete clicked');
                          });
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
