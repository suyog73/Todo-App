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
    on<MarkFavoriteOrUnFavoriteTask>(_onMarkFavoriteOrUnFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedTasks: state.removedTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  // Used to toggle checkbox
  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTask = state.completedTasks;
    List<Task> favoriteTask = state.favoriteTasks;
    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));
      } else {
        int taskIdx = favoriteTask.indexOf(task);

        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));

        favoriteTask.remove(task);
        favoriteTask.insert(
          taskIdx,
          task.copyWith(isDone: true),
        );
      }
    } else {
      if (task.isFavorite == false) {
        completedTask = List.from(completedTask)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        int taskIdx = favoriteTask.indexOf(task);
        completedTask = List.from(completedTask)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));

        favoriteTask.remove(task);

        favoriteTask.insert(
          taskIdx,
          task.copyWith(isDone: false),
        );
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        completedTasks: completedTask,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> removedTasks = List.from(state.removedTasks)..remove(task);
    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        removedTasks: removedTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(
      TasksState(
        pendingTasks: List.from(state.pendingTasks)..remove(task),
        completedTasks: List.from(state.completedTasks)..remove(task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  void _onMarkFavoriteOrUnFavoriteTask(
      MarkFavoriteOrUnFavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTask = state.completedTasks;
    List<Task> favoriteTask = state.favoriteTasks;

    // If task is pending
    if (event.task.isDone == false) {
      // If task is not favorite
      if (event.task.isFavorite == false) {
        var taskIdx = pendingTasks.indexOf(event.task);

        // remove same task from pending and again insert with isFavorite as true
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIdx, event.task.copyWith(isFavorite: true));

        // also add to favorite list with isFavorite as true
        favoriteTask = List.from(favoriteTask)
          ..insert(0, event.task.copyWith(isFavorite: true));
      }
      // If task is favorite
      else {
        var taskIdx = pendingTasks.indexOf(event.task);

        // remove same task from pending and again insert with isFavorite as false
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIdx, event.task.copyWith(isFavorite: false));

        // just remove from favorite list
        favoriteTask.remove(event.task);
      }
    }
    // If task is completed
    else {
      // If task is not favorite
      if (event.task.isFavorite == false) {
        var taskIdx = completedTask.indexOf(event.task);

        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(
            taskIdx,
            event.task.copyWith(isFavorite: true),
          );

        favoriteTask.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIdx = completedTask.indexOf(event.task);

        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(
            taskIdx,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTask.remove(event.task);
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        favoriteTasks: favoriteTask,
        completedTasks: completedTask,
        removedTasks: state.removedTasks,
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

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    Task oldTask = event.oldTask;
    Task newTask = event.newTask;

    List<Task> favoriteTask = state.favoriteTasks;
    List<Task> pendingTask = state.pendingTasks;

    if (oldTask.isFavorite == true) {
      favoriteTask
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    pendingTask = List.from(pendingTask)
      ..remove(oldTask)
      ..insert(0, newTask);

    emit(
      TasksState(
        pendingTasks: pendingTask,
        favoriteTasks: favoriteTask,
        completedTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;

    Task task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTask = state.completedTasks;
    List<Task> favoriteTask = state.favoriteTasks;
    List<Task> removedTask = state.removedTasks;

    removedTask = List.from(removedTask)..remove(task);
    pendingTasks = List.from(pendingTasks)
      ..insert(
          0,
          task.copyWith(
            isDeleted: false,
            isDone: false,
            isFavorite: false,
          ));

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        favoriteTasks: favoriteTask,
        completedTasks: completedTask,
        removedTasks: removedTask,
      ),
    );
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(
      TasksState(
        pendingTasks: state.pendingTasks,
        favoriteTasks: state.favoriteTasks,
        completedTasks: state.completedTasks,
        removedTasks: List.from(state.removedTasks)..clear(),
      ),
    );
  }
}
