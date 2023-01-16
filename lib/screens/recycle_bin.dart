// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/screens/my_drawer.dart';
import 'package:todo_bloc/widgets/task_lists.dart';

import '../blocs/bloc_exports.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  static const id = "recycle_bin_screen";

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
                const Text("Recycle Bin"),
                Text("${state.removedTasks.length}"),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.removedTasks.isEmpty
                  ? Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Lottie.asset("assets/lottie/bin.json",
                                repeat: false),
                          ),
                          const Center(
                            child: Text(
                              "Recycle Bin is Empty",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : TasksList(taskList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
