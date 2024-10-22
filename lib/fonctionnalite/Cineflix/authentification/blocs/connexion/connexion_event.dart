part of 'connexion_bloc.dart';

sealed class ConnexionEvent extends Equatable {
  const ConnexionEvent();

  @override
  List<Object> get props => [];
}

final class ConnexionEmailChanged extends ConnexionEvent {
  const ConnexionEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}
final class ConnexionUsernameChanged extends ConnexionEvent {
  const ConnexionUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class ConnexionPasswordChanged extends ConnexionEvent {
  const ConnexionPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class ConnexionSubmitted extends ConnexionEvent {
  const ConnexionSubmitted();
}

