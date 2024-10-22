import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum InternetState { connected, disconnected }

class InternetCubit extends Cubit<InternetState> {
  final InternetConnection _internetChecker;
  late StreamSubscription<InternetStatus> _internetStatusSubscription;

  InternetCubit(this._internetChecker) : super(InternetState.disconnected) {
    _internetStatusSubscription = _internetChecker.onStatusChange.listen(_handleInternetStatusChange);
  }

  void _handleInternetStatusChange(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        emit(InternetState.connected);
        break;
      case InternetStatus.disconnected:
        emit(InternetState.disconnected);
        break;
    }
  }

  @override
  Future<void> close() {
    _internetStatusSubscription.cancel();
    return super.close();
  }
}