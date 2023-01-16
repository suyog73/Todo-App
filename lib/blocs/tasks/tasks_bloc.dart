import 'package:equatable/equatable.dart';
import 'package:todo_bloc/blocs/bloc_exports.dart';
import 'package:todo_bloc/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..add(event.task),
        removedTasks: state.removedTasks,
      ),
    );
  }

  // Used to toggle checkbox
  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final index = state.allTasks.indexOf(task);

    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    emit(
      TasksState(allTasks: allTasks, removedTasks: state.removedTasks),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> removedTasks = List.from(state.removedTasks)..remove(task);
    emit(
      TasksState(allTasks: state.allTasks, removedTasks: removedTasks),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
