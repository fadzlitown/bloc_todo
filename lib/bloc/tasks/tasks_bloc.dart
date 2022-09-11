import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_better_muslim/bloc/bloc_exports.dart';

import '../../models/task.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

// HydratedBloc local db storage
class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<LikeOrDislikeTask>(_onLikeOrDislikeTask);
    on<EditTask>(_onEditTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favTasks: state.favTasks,
        removedTasks: state.removedTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            //action from isDone false to true
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            //action from isDone true to false
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false)),
          };

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favTasks: state.favTasks,
        removedTasks: state.removedTasks));

    //old logic
    // final int index = state.pendingTasks.indexOf(task);
    // List<Task> allTasks = List.from(state.pendingTasks)..remove(task);
    // task.isDone == false
    //     ? allTasks.insert(index, task.copyWith(isDone: true))
    //     : allTasks.insert(index, task.copyWith(isDone: false));
    // emit(TasksState(pendingTasks: allTasks, removedTasks: state.removedTasks));
  }

  void _onLikeOrDislikeTask(LikeOrDislikeTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favouriteTasks = state.favTasks;
    if (event.task.isDone == false) {
      if (event.task.isFav == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFav: true));
        favouriteTasks.add(event.task.copyWith(isFav: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFav: false));
        favouriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFav == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFav: true));
        favouriteTasks.insert(0, event.task.copyWith(isFav: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFav: false));
        favouriteTasks.remove(event.task);
      }
    }
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favTasks: favouriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favTasks;
    if (event.oldTask.isFav == true) {
      //check if edit task included in fav list or not, if yes replace it
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(
      TasksState(
        //replace edited task inside pending tasks
        pendingTasks: List.from(state.pendingTasks)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTasks: state.completedTasks..remove(event.oldTask),
        favTasks: favouriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  FutureOr<void> _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> removeTaskFromRemovedList = List.from(state.removedTasks)
      ..remove(event.task);
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favTasks: state.favTasks,
        removedTasks: removeTaskFromRemovedList));
  }

  FutureOr<void> _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTasks = List.from(state.pendingTasks)..remove(event.task);
    List<Task> completedTasks = List.from(state.completedTasks)
      ..remove(event.task);
    List<Task> favTasks = List.from(state.favTasks)..remove(event.task);

    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favTasks: favTasks,
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true))));
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
