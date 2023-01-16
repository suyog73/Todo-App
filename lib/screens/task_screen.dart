import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/screens/add_task_screen.dart';
import 'package:todo_bloc/screens/my_drawer.dart';
import 'package:todo_bloc/widgets/task_lists.dart';

import '../blocs/bloc_exports.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  static const id = "task_screen";

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;

        return Scaffold(
          key: key,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addTask(context);
            },
            backgroundColor: lightPrimaryColor,
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: lightPrimaryColor,
                padding: const EdgeInsets.only(
                    top: 60, left: 30, right: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => key.currentState!.openDrawer(),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.list,
                          size: 30,
                          color: lightPrimaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'ToDo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${tasksList.length} Tasks',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              tasksList.isEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Lottie.asset("assets/lottie/tasks.json"),
                            ),
                            const Center(
                              child: Text(
                                "Try to add new task",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : TasksList(taskList: tasksList),
            ],
          ),
        );
      },
    );
  }
}
