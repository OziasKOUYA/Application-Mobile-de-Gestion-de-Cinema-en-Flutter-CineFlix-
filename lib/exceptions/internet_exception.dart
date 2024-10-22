class   InternetException implements Error{
  final String message;

  InternetException(this.message);
  @override
  String toString() => message;

  @override
  StackTrace? get stackTrace => throw message;
}