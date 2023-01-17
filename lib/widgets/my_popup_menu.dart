import 'package:flutter/material.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.task,
    required this.likeOrDislikeCallback,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  }) : super(key: key);

  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? (context) => [
                PopupMenuItem(
                  child: InkWell(
                    onTap: editTaskCallback,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: editTaskCallback,
                        icon: Icon(Icons.edit, color: lightPrimaryColor),
                        label: const Text("Edit"),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislikeCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == true
                        ? Icon(Icons.favorite, color: lightPrimaryColor)
                        : Icon(Icons.favorite_border, color: lightPrimaryColor),
                    label: task.isFavorite == true
                        ? const Text("Remove from\nfavorite")
                        : const Text("Add to\nfavorite"),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.delete, color: lightPrimaryColor),
                    label: const Text("Delete"),
                  ),
                ),
              ]
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.restore_rounded, color: lightPrimaryColor),
                    label: const Text("Restore"),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.delete_forever, color: lightPrimaryColor),
                    label: const Text("Delete Forever"),
                  ),
                ),
              ],
    );
  }
}
