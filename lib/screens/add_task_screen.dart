import 'package:flutter/material.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/services/guid_generator.dart';

import '../blocs/bloc_exports.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Add task", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          TextField(
            controller: titleController,
            autofocus: true,
            decoration: const InputDecoration(
                label: Text("Title"), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Task task =
                      Task(title: titleController.text, id: GUIDGen.generate());
                  context.read<TasksBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
