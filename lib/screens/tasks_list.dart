import 'package:flutter/material.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: getListView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
        debugPrint(' FAB clicked');
      },
            tooltip: 'Add Task',
           child: const Icon(Icons.add_task_sharp ),),
    );
  }

  ListView getListView() {

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.yellow[200],
          elevation: 2.0,
          child:  ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.arrow_forward),
            ),
            title: const Text('Dummy Title'),
            subtitle: const Text('Dummy Date'),
            trailing: const Icon(Icons.delete, color: Colors.blueGrey,),
            onTap: () {
              debugPrint('List tapped');
            },
          ),
        );
      },
    );
  }
}
