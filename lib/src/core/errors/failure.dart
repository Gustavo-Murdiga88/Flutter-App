class Failure {
  final String message;
  final int? status;
  final StackTrace stackTrace;

  Failure({
    required this.message,
    this.status,
    required this.stackTrace,
  });
}
