part of 'connexion_bloc.dart';

final class ConnexionState extends Equatable {
  const ConnexionState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.errorMessage = '',
    this.isValid = false,
    this.username = const Username.pure(),

  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final bool isValid;
  final String errorMessage;
  final Username username;


  ConnexionState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    bool? isValid,
    String? errorMessage,
    bool?rememberMe,
    Username? username,
  }) {
    return ConnexionState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [status, email,username, password,errorMessage];
}
