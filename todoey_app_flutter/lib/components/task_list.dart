import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_app_flutter/components/task_tile.dart';
import 'package:todoey_app_flutter/models/task.dart';
import 'package:todoey_app_flutter/models/task_data.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (BuildContext context, TaskData taskData, Widget? child) {
        return ListView.builder(
          padding: const EdgeInsets.all(40.0),
          itemCount: taskData.taskCount,
          itemBuilder: (BuildContext context, int index) {
            final Task task = taskData.tasks[index];
            return GestureDetector(
              onLongPress: () {
                taskData.deleteTask(task);
              },
              child: TaskTile(
                taskTitle: task.name,
                isChecked: task.isDone,
                checkboxCallback: (bool? value) {
                  // setState(() {
                  //   widget.tasks[index].toggleDone();
                  // });
                  taskData.updateTask(task);
                },
              ),
            );
          },
        );
      },
    );
  }
}
