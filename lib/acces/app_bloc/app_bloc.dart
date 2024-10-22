import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppLoading()) {
    on<AppStarted>(_onAppStarted);
  }

  void _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTimeOodime') ?? true;

    if (isFirstTime) {
      prefs.setBool('isFirstTimeOodime', false);
      emit(OnboardingState());
    } else {
      emit(HomeState());
    }
  }
}