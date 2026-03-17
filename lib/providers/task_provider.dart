import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {

  late Box<Task> taskBox;

  List<Task> tasks = [];

  TaskProvider() {
    loadTasks();
  }

  void loadTasks() {
    taskBox = Hive.box<Task>('tasks');
    tasks = taskBox.values.toList();
    notifyListeners();
  }

  void addTask(String title, String? description) {

    final newTask = Task(
      title: title,
      description: description,
    );

    taskBox.add(newTask);

    tasks = taskBox.values.toList();

    notifyListeners();
  }

  void toggleTask(int index) {

    tasks[index].isCompleted = !tasks[index].isCompleted;

    taskBox.putAt(index, tasks[index]);

    notifyListeners();
  }
}