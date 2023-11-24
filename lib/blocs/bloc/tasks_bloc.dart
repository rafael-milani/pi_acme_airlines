import 'package:acme_airlines_pi/models/task.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    }

    void _onAddTask(AddTask event, Emitter<TasksState> emit){
      final state = this.state;
      emit (TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        ));
  }

    void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit){
      final state = this.state;
      final task = event.task;

      List<Task> pendingTasks = state.pendingTasks;
      List<Task> completedTasks = state.completedTasks;
      task.isDone == false
        ? {
          pendingTasks = List.from(pendingTasks)..remove(task),
          completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true)),
          }
        : {
          completedTasks = List.from(completedTasks)..remove(task),
          pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false)),
          };

      emit (TasksState(
        pendingTasks: pendingTasks, 
        completedTasks: completedTasks, 
        ));
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
