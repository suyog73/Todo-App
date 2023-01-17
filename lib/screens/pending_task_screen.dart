import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/models/task.dart';
import 'package:todo_bloc/screens/add_task_screen.dart';
import 'package:todo_bloc/screens/my_drawer.dart';
import 'package:todo_bloc/services/get_date_time.dart';
import 'package:todo_bloc/widgets/task_lists.dart';

import '../blocs/bloc_exports.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({Key? key}) : super(key: key);

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
        List<Task> tasksList = state.pendingTasks;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                          '${tasksList.length} Pending Tasks ',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GetDateAndTime().getWeekDay(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          GetDateAndTime().getDate(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
