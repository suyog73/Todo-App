// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/services/guid_generator.dart';

import '../blocs/bloc_exports.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Add Task", style: TextStyle(fontSize: 24)),
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
                  Task task = Task(
                    title: titleController.text,
                    id: GUIDGen.generate(),
                    description: descriptionController.text,
                    date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
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
                    "Add",
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
