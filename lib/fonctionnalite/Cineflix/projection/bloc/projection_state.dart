part of 'projection_bloc.dart';


abstract class ProjectionState extends Equatable {
  const ProjectionState();
}

class ProjectionInitial extends ProjectionState {
  @override
  List<Object> get props => [];
}

class ProjectionLoadInProgress extends ProjectionState {
  @override
  List<Object> get props => [];
}

class ProjectionLoadSuccess extends ProjectionState {
  final List<Projection> projection;

  const ProjectionLoadSuccess(this.projection);

  @override
  List<Object> get props => [projection];
}


class ProjectionOperationFailure extends ProjectionState {
  final String error;

  const ProjectionOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
