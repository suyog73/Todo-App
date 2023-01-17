import 'package:flutter/material.dart';
import 'package:todo_bloc/models/task.dart';

import '../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      onLongPress: () => _removeOrDeleteTask(context, task),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted!
            ? null
            : (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              },
      ),
    );
  }
}
