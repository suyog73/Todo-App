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
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          showAlertDialog(context);
                        },
                        child: const Icon(Icons.delete_forever_sharp)),
                    Text("${state.removedTasks.length}"),
                  ],
                ),
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

  Widget generateButton(String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity * 0.4,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: name == "Delete" ? lightPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget deleteButton = InkWell(
        onTap: () {
          context.read<TasksBloc>().add(DeleteAllTask());

          Navigator.pop(context);
        },
        child: generateButton("Delete"));

    // set up the button
    Widget cancelButton = InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: generateButton("Cancel"));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceBetween,
      title: const Text("Delete Forever"),
      content:
          const Text("After deleting task you are not able to restore them."),
      actions: [cancelButton, deleteButton],
    );

    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text("Nothing to Delete"),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return context.read<TasksBloc>().state.removedTasks.isEmpty
            ? alertDialog
            : alert;
      },
    );
  }
}
