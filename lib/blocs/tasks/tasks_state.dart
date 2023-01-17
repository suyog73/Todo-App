part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> removedTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;

  const TasksState({
    this.pendingTasks = const <Task>[],
    this.removedTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
  });

  @override
  List<Object?> get props =>
      [pendingTasks, removedTasks, completedTasks, favoriteTasks];

  Map<String, dynamic> toMap() {
    return {
      "pendingTasks": pendingTasks.map((e) => e.toMap()).toList(),
      "removedTasks": removedTasks.map((e) => e.toMap()).toList(),
      "completedTasks": completedTasks.map((e) => e.toMap()).toList(),
      "favoriteTasks": favoriteTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> mp) {
    return TasksState(
      pendingTasks:
          List<Task>.from(mp["pendingTasks"]?.map((e) => Task.fromMap(e))),
      removedTasks:
          List<Task>.from(mp["removedTasks"]?.map((e) => Task.fromMap(e))),
      completedTasks:
          List<Task>.from(mp["completedTasks"]?.map((e) => Task.fromMap(e))),
      favoriteTasks:
          List<Task>.from(mp["favoriteTasks"]?.map((e) => Task.fromMap(e))),
    );
  }
}
