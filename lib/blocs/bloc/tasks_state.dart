part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;

  const TasksState({
    this.pendingTasks = const<Task>[],
    this.completedTasks = const<Task>[],
    });
  
  @override
  List<Object> get props => [
    pendingTasks,
    completedTasks, 
    ];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: 
      List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      completedTasks: 
      List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
    );
  }
}

