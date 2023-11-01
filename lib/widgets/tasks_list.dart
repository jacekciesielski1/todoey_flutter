import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';

class TaskTile extends StatelessWidget {
  bool isChecked = false;
  String title;
  final Function(bool?) checkboxCallback;
  TaskTile(this.isChecked, this.title, this.checkboxCallback);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkboxCallback,
        ));
  }
}

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                Provider.of<TaskData>(context, listen: false).deleteTask(index);
              },
              child: TaskTile(
                taskData.tasks[index].isDone,
                taskData.tasks[index].name,
                (bool? checkboxState) {
                  Provider.of<TaskData>(context, listen: false)
                      .updateTask(taskData.tasks[index], index);
                },
              ),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
