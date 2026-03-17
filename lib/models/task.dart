import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  final DateTime createdTime;

  Task({
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdTime,
  }) : createdTime = createdTime ?? DateTime.now();
}