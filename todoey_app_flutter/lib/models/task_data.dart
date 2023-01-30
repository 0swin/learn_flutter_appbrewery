import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todoey_app_flutter/models/task.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = <Task>[
    Task(name: "Buy Milk"),
    Task(name: "Buy Eggs"),
    Task(name: "Buy Bread"),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView<Task>(_tasks);
  }

  void addTask(String newTaskTitle) {
    _tasks.add(Task(name: newTaskTitle));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  void deleteDoneTasks() {
    _tasks.removeWhere((Task task) => task.isDone);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
