import 'package:flutter/material.dart';
import 'package:todo_bloc/blocs/bloc_exports.dart';
import 'package:todo_bloc/models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, int index) {
          var task = taskList[index];

          return ListTile(
            title: Text(task.title),
            onLongPress: () =>
                context.read<TasksBloc>().add(DeleteTask(task: task)),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
            ),
          );
        },
      ),
    );
  }
}
