part of 'salle_bloc.dart';

abstract class SalleState extends Equatable {
  const SalleState();
}

class SalleInitial extends SalleState {
  @override
  List<Object> get props => [];
}

class SalleLoadInProgress extends SalleState {
  @override
  List<Object> get props => [];
}

class SalleLoadSuccess extends SalleState {
  final List<Salle> salles;

  const SalleLoadSuccess(this.salles);

  @override
  List<Object> get props => [salles];
}


class SalleOperationFailure extends SalleState {
  final String error;

  const SalleOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
