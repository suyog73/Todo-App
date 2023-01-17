import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/screens/edit_task_screen.dart';
import 'package:todo_bloc/widgets/my_popup_menu.dart';

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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (task.isDeleted == false) {
                      context.read<TasksBloc>().add(
                            MarkFavoriteOrUnFavoriteTask(task: task),
                          );
                    }
                  },
                  child: task.isFavorite == true
                      ? Icon(Icons.favorite, color: lightPrimaryColor)
                      : const Icon(Icons.favorite_border),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat().add_yMMMd().add_Hm().format(
                              DateTime.parse(task.date),
                            ),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted!
                    ? null
                    : (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      },
              ),
              MyPopupMenu(
                task: task,
                cancelOrDeleteCallback: () =>
                    _removeOrDeleteTask(context, task),
                likeOrDislikeCallback: () => context.read<TasksBloc>().add(
                      MarkFavoriteOrUnFavoriteTask(task: task),
                    ),
                editTaskCallback: () {
                  Navigator.pop(context);
                  _editTask(context);
                },
                restoreTaskCallback: () => context.read<TasksBloc>().add(
                      RestoreTask(task: task),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ListTile(
// title: Text(
// task.title,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// decoration: task.isDone! ? TextDecoration.lineThrough : null),
// ),
// onLongPress: () => _removeOrDeleteTask(context, task),
// trailing: Checkbox(
// value: task.isDone,
// onChanged: task.isDeleted!
// ? null
// : (value) {
// context.read<TasksBloc>().add(UpdateTask(task: task));
// },
// ),
// );
