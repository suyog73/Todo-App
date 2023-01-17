// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/screens/my_drawer.dart';
import 'package:todo_bloc/widgets/task_lists.dart';

import '../blocs/bloc_exports.dart';

class FavoriteTaskScreen extends StatelessWidget {
  const FavoriteTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          key: key,
          drawer: const MyDrawer(),
          appBar: AppBar(
            backgroundColor: lightPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Favorite Task"),
                Text("${state.favoriteTasks.length}"),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.favoriteTasks.isEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Lottie.asset("assets/lottie/empty.json",
                                repeat: false),
                          ),
                          const Center(
                            child: Text(
                              "Favorite task is Empty",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : TasksList(taskList: state.favoriteTasks),
            ],
          ),
        );
      },
    );
  }
}
