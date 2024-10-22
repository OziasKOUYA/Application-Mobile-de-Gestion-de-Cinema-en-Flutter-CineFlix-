part of 'authentification_bloc.dart';


class AuthentificationState extends Equatable {

  const AuthentificationState._( {
    this.status = AuthentificationStatus.unknown,
    this.username= ''


  });

  const AuthentificationState.unknown() : this._();
  const AuthentificationState.authenticated(String username)
      : this._(status: AuthentificationStatus.authenticated,username:username);

  const AuthentificationState.unauthenticated()
      : this._(status: AuthentificationStatus.unauthenticated);

  final AuthentificationStatus status;
  final String username;



  @override
  List<Object> get props => [status,username];
}
