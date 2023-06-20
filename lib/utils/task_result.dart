class TaskResult {
  bool isSuccess;
  String? title;
  String? message;
  Object? data;
  TaskResult({
    required this.isSuccess,
    this.title,
    this.message,
    this.data,
  });
}
