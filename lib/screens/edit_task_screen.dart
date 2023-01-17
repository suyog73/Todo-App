// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';

import '../blocs/bloc_exports.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({Key? key, required this.oldTask}) : super(key: key);
  final Task oldTask;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Edit Task", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            controller: titleController,
            autofocus: true,
            cursorColor: lightPrimaryColor,
            decoration: kInputDecoration.copyWith(
              label: Text(
                "Title",
                style: TextStyle(color: lightPrimaryColor, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            cursorColor: lightPrimaryColor,
            minLines: 3,
            maxLines: 5,
            decoration: kInputDecoration.copyWith(
              label: Text(
                "Description",
                style: TextStyle(color: lightPrimaryColor, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: lightPrimaryColor, fontSize: 18),
                ),
              ),
              InkWell(
                onTap: () {
                  Task editedTask = Task(
                    title: titleController.text,
                    id: oldTask.id,
                    isFavorite: oldTask.isFavorite,
                    description: descriptionController.text,
                    date: DateTime.now().toString(),
                    isDone: false,
                  );
                  context.read<TasksBloc>().add(
                        EditTask(oldTask: oldTask, newTask: editedTask),
                      );
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: lightPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(color: lightSecondaryColor, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
