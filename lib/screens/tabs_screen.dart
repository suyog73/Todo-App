import 'package:flutter/material.dart';
import 'package:todo_bloc/screens/completed_task_screen.dart';
import 'package:todo_bloc/screens/favorite_task_screen.dart';
import 'package:todo_bloc/screens/pending_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const String id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> screens = const [
    PendingTasksScreen(),
    CompletedTaskScreen(),
    FavoriteTaskScreen(),
  ];

  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (int value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Pending Task",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed Task",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite Task",
          ),
        ],
      ),
      body: screens[_selectedPageIndex],
    );
  }
}
