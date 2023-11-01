import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:todoey_flutter/models/notifications.dart';

class Task {
  final String name;
  bool isDone;
  int id;

  Task({required this.name, this.isDone = false, required this.id});

  void toggleDone() {
    isDone = !isDone;
  }
}

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: "Kupić mleko", id: 1),
    Task(name: "Kupić jajka", id: 2),
    Task(name: "Iść na siłownie", id: 3),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle, int taskId) {
    final task = Task(name: newTaskTitle, id: taskId);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task, int index) {
    task.toggleDone();
    deleteNotification(tasks[index].id);
    notifyListeners();
  }

  void deleteTask(int index) {
    deleteNotification(tasks[index].id);
    _tasks.removeAt(index);
    notifyListeners();
  }
}
