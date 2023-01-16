part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> removedTasks;

  const TasksState({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  @override
  List<Object?> get props => [allTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      "allTasks": allTasks.map((e) => e.toMap()).toList(),
      "removedTasks": removedTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> mp) {
    return TasksState(
      allTasks: List<Task>.from(mp["allTasks"]?.map((e) => Task.fromMap(e))),
      removedTasks:
          List<Task>.from(mp["removedTasks"]?.map((e) => Task.fromMap(e))),
    );
  }
}
