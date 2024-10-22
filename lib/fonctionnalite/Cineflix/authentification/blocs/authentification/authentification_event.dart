part of 'authentification_bloc.dart';

sealed class AuthentificationEvent {
  const AuthentificationEvent();
}

final class AuthentificationAppStarted extends AuthentificationEvent {
  const AuthentificationAppStarted();


}

final class AuthentificationStatusChanged extends AuthentificationEvent {
const AuthentificationStatusChanged(this.status);

final AuthentificationStatus status;
}

final class AuthentificationLogoutRequested extends AuthentificationEvent {
  const AuthentificationLogoutRequested();
}

final class AuthentificationAutoLoginRequested extends AuthentificationEvent {
  const AuthentificationAutoLoginRequested();


}