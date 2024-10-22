import 'package:flutter/material.dart';

enum SignupStatus { initial, loading, success, failed }

class SignupState {
  final SignupStatus status;
  final String? message;
  final Color buttonColor;
  final IconData? buttonIcon;

  SignupState({
    required this.status,
    this.message,
    required this.buttonColor,
    this.buttonIcon,
  });

  factory SignupState.initial() {
    return SignupState(
      status: SignupStatus.initial,
      buttonColor:Colors.green,
      buttonIcon: null,
    );
  }

  factory SignupState.loading() {
    return SignupState(
      status: SignupStatus.loading,
      buttonColor: Colors.black,
      buttonIcon: null,
    );
  }

  factory SignupState.success() {
    return SignupState(
      status: SignupStatus.success,
      buttonColor: Colors.green,
      buttonIcon: Icons.check,
    );
  }

  factory SignupState.failed(String message) {
    return SignupState(
      status: SignupStatus.failed,
      message: message,
      buttonColor: Colors.red,
      buttonIcon: Icons.error_outline,

    );
  }
}
