import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/notification_service.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
            task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                NotificationService.showNotification(
                  title: "Task Reminder",
                  body: task.title,
                );
              },
            ),

            Checkbox(
              value: task.isCompleted,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}