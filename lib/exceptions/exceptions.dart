class FuzExceptions implements Error{
  final String message;

  FuzExceptions(this.message);

  @override
  StackTrace? get stackTrace => throw message;
  @override
  String toString() => message;
}
