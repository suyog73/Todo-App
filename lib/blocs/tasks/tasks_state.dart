part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;

  const TasksState({
    this.allTasks = const <Task>[],
  });

  @override
  List<Object?> get props => [allTasks];

  Map<String, dynamic> toMap() {
    return {
      "allTasks": allTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> mp) {
    return TasksState(
      allTasks: List<Task>.from(mp["allTasks"]?.map((e) => Task.fromMap(e))),
    );
  }
}
