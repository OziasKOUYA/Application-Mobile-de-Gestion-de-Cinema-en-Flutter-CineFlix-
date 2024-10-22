import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/authentification/models/user_add.dart';
import 'package:equatable/equatable.dart';

import '../../../../../utils/helper/secureStorage.dart';
import '../../authentification_service.dart';




part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  AuthentificationBloc({
    required AuthentificationService authentificationService,
  })  : _authentificationService = authentificationService,

        super( const AuthentificationState.unknown()) {
    on<AuthentificationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthentificationAutoLoginRequested>(_onAuthentificationAutoLoginRequested);
  on<AuthentificationLogoutRequested>(_onAuthentificationLogoutRequested);
    _authentificationStatusSubscription = _authentificationService.status.listen(
          (status) => add(AuthentificationStatusChanged(status)),
    );
  }

  final AuthentificationService _authentificationService;
  late StreamSubscription<AuthentificationStatus>
  _authentificationStatusSubscription;

  @override
  Future<void> close() {
    _authentificationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
      AuthentificationStatusChanged event,
      Emitter<AuthentificationState> emit,
      ) async {
    print(event.status);
    switch (event.status) {
      case AuthentificationStatus.autoLoginAttempt:
        final bool keyExists = await FuzSecureStorageManager.containsKey('access_token');

        if (keyExists) {
          final user = await _tryGetUser();


          if (user != null ) {
            emit(AuthentificationState.authenticated(user.username!));
          } else {
            emit(const AuthentificationState.unauthenticated());
          }
        } else {
          emit(const AuthentificationState.unauthenticated());
        }
      case AuthentificationStatus.unauthenticated:
        emit(const AuthentificationState.unauthenticated());
        break;

      case AuthentificationStatus.authenticated:
        String? username = await FuzSecureStorageManager.read('username');
          emit(AuthentificationState.authenticated(username!));

        break;

      case AuthentificationStatus.unknown:
        emit(const AuthentificationState.unknown());
        break;
    }
  }
  Future<void> _onAuthentificationLogoutRequested(
      AuthentificationLogoutRequested event,
      Emitter<AuthentificationState> emit,
      ) async {
    try {
      await FuzSecureStorageManager.delete('access_token');
      emit(const AuthentificationState.unauthenticated());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _onAuthentificationAutoLoginRequested(
  AuthentificationAutoLoginRequested event,
      Emitter<AuthentificationState> emit,
  ) async {

    try {
      final user = await _tryGetUser();
      if (user != null) {
        emit(AuthentificationState.authenticated(user.username!));
      } else {
        emit(const AuthentificationState.unauthenticated());
      }

    } catch (e) {
      throw Exception(e.toString());
    }


}






Future<User_add?> _tryGetUser() async {
    String? username = await FuzSecureStorageManager.read('username');
    String? password = await FuzSecureStorageManager.read('password');
    String? email = await FuzSecureStorageManager.read('email');
    User_add? user_log  = User_add(username: username, password1:password, email: email);
    try {
      User_add? user = await _authentificationService.login(user_log);
      return user;
    } catch (e) {
      return null;
    }
  }
}
