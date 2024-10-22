import 'package:bloc/bloc.dart';


import '../../authentification_service.dart';
import '../../models/user_add.dart';
import 'inscription_states.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthentificationService _authentificationService;
  SignupCubit({
    required AuthentificationService authentificationService,
  }) : _authentificationService = authentificationService, super (SignupState.initial());

  void submitForm(Map<String, dynamic> formData) async {
    emit(SignupState.loading());
    try {
      final user = User_add(
        username: formData['username'],
        email:  formData['email'],
        password1: formData['password1'],
        password2: formData['password1'],
      );

      await _authentificationService.register(user);

      emit(SignupState.success());
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(SignupState.initial());
      });
    } catch (e) {

        print(e.toString());
        emit(SignupState.failed('An error occured , try again later'));
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(SignupState.initial());
        });
      }
    }
}