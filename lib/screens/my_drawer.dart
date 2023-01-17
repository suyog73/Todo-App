import 'package:flutter/material.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/screens/recycle_bin.dart';
import 'package:todo_bloc/screens/tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: Colors.grey.withOpacity(0.1),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello there!!",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          state.themeValue
                              ? context.read<ThemeBloc>().add(LightThemeEvent())
                              : context.read<ThemeBloc>().add(DarkThemeEvent());
                        },
                        child: Icon(
                          state.themeValue ? Icons.light_mode : Icons.dark_mode,
                          color: lightPrimaryColor,
                          size: 36,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(TabsScreen.id),
                  title: const Text(
                    "Pending Tasks",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Text("${state.pendingTasks.length}"),
                  leading: Icon(
                    Icons.folder_special,
                    color: lightPrimaryColor,
                  ),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  title: const Text(
                    "Bin",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Text("${state.removedTasks.length}"),
                  leading: Icon(
                    Icons.delete,
                    color: lightPrimaryColor,
                  ),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
