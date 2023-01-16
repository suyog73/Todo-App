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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = taskList[index];

            return TaskTile(task: task);
          },
        ),
      ),
    );
  }
}
