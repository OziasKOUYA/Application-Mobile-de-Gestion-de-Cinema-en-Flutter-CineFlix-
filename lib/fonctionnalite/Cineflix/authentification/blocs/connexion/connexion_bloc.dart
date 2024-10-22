import 'package:bloc/bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/authentification/models/connexion_models/username.dart';
import 'package:cineflix/fonctionnalite/Cineflix/authentification/models/user_add.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../exceptions/authentication_exception.dart';
import '../../authentification_service.dart';
import '../../models/connexion_models/email.dart';
import '../../models/connexion_models/password.dart';


part 'connexion_event.dart';
part 'connexion_state.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  ConnexionBloc({
    required AuthentificationService authentificationService,
  })
      : _authentificationService = authentificationService,
        super(const ConnexionState()) {
    on<ConnexionEmailChanged>(_onEmailChanged);
    on<ConnexionPasswordChanged>(_onPasswordChanged);
    on<ConnexionSubmitted>(_onSubmitted);
    on<ConnexionUsernameChanged>(_onUsernameChanged);

  }

  final AuthentificationService _authentificationService;

  void _onEmailChanged(ConnexionEmailChanged event,
      Emitter<ConnexionState> emit,) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password,email,state.username ]),
      ),
    );
  }
  void _onUsernameChanged(ConnexionUsernameChanged event,
      Emitter<ConnexionState> emit,) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password,state.email,username]),
      ),
    );
  }

  void _onPasswordChanged(ConnexionPasswordChanged event,
      Emitter<ConnexionState> emit,) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(ConnexionSubmitted event,
      Emitter<ConnexionState> emit,) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authentificationService.login(
          User_add(
            email: state.email.value,
            username: state.username.value,
            password1: state.password.value
          )
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));

      } catch (e) {
        if (e is AuthenticationException) {
          emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: e.message));
        } else {
          print(e.toString());
          emit(state.copyWith(status: FormzSubmissionStatus.failure, errorMessage: 'Impossible de joindre le serveur distant,verifier votre connexion internet'));
        }
      }
    }
  }

}
