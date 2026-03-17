class Task {
  final String title;
  final String? description;
  bool isCompleted;
  final DateTime createdTime;

  Task({
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdTime,
  }) : createdTime = createdTime ?? DateTime.now();
}