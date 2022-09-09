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
