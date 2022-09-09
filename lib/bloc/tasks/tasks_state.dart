part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favTasks;
  final List<Task> removedTasks;

  const TasksState(
      {this.completedTasks = const <Task>[],
      this.favTasks = const <Task>[],
      this.pendingTasks = const <Task>[],
      this.removedTasks = const <Task>[]});

  // const TasksState({
  //   this.allTasks,
  // });

  @override
  List<Object> get props =>
      [completedTasks, favTasks, pendingTasks, removedTasks];

  Map<String, dynamic> toMap() {
    return {
      'completedTasks': completedTasks.map((e) => e.toMap()).toList(),
      'favTasks': favTasks.map((e) => e.toMap()).toList(),
      'pendingTasks': pendingTasks.map((e) => e.toMap()).toList(),
      'removedTasks': removedTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      completedTasks:
          List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
      favTasks: List<Task>.from(map['favTasks']?.map((x) => Task.fromMap(x))),
      pendingTasks:
          List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      removedTasks:
          List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
