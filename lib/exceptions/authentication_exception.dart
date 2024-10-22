class AuthenticationException implements Error{
  final String message;

  AuthenticationException(this.message);
  @override
  String toString() => message;

  @override
  StackTrace? get stackTrace => throw message;
}