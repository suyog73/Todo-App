import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_bloc/helpers/constants.dart';
import 'package:todo_bloc/screens/recycle_bin.dart';
import 'package:todo_bloc/screens/tabs_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                                  ? context
                                      .read<ThemeBloc>()
                                      .add(LightThemeEvent())
                                  : context
                                      .read<ThemeBloc>()
                                      .add(DarkThemeEvent());
                            },
                            child: Icon(
                              state.themeValue
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
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
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(TabsScreen.id),
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
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(RecycleBin.id),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Developed by Suyog Patil",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          launchEmail("suyog732002@gmail.com");
                        },
                        child: const Icon(Icons.mail, size: 36),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchURL("https://github.com/suyog73");
                        },
                        child: const Icon(FontAwesomeIcons.github, size: 32),
                      ),
                      InkWell(
                        onTap: () async {
                          await launchURL(
                              "https://www.linkedin.com/in/suyog-patil7/");
                        },
                        child: const Icon(
                          FontAwesomeIcons.linkedin,
                          color: Colors.lightBlue,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchEmail(emailAddress) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: emailAddress,
        queryParameters: {'subject': '', 'body': ''});

    String url = params.toString();

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURL(localUrl) async {
    String url = localUrl;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
