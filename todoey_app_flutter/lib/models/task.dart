class Task {
  Task({required this.name, this.isDone = false});

  final String name;
  bool isDone;

  void toggleDone() {
    isDone = !isDone;
  }
}
