import 'package:flutter/material.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ExpansionPanelList.radio(
              key: GlobalKey(),
              children: taskList
                  .map(
                    (task) => ExpansionPanelRadio(
                      value: task.id,
                      headerBuilder: (context, isOpen) => TaskTile(task: task),
                      body: ListTile(
                        title: SelectableText.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Title\n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: task.title),
                              const TextSpan(
                                text: "\n\nDescription\n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: task.description),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Expanded(
// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// decoration: const BoxDecoration(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// ),
// child: ListView.builder(
// itemCount: taskList.length,
// itemBuilder: (BuildContext context, int index) {
// Task task = taskList[index];
//
// return TaskTile(task: task);
// },
// ),
// ),
// );
