part of 'projection_bloc.dart';

abstract class ProjectionEvent extends Equatable {
  const ProjectionEvent();
}

class LoadProjections extends ProjectionEvent {

  const LoadProjections();
  @override
  List<Object> get props => [];
}


class AddProjection extends ProjectionEvent {

  final Projection projection;

  const AddProjection( this.projection);

  @override
  List<Object> get props => [projection];
}

class UpdateProjection extends ProjectionEvent {
  final Projection projection;

  const UpdateProjection( this.projection);

  @override
  List<Object> get props => [projection];
}

class DeleteProjection extends ProjectionEvent {
  final Projection projection;


  const DeleteProjection( this.projection);

  @override
  List<Object> get props => [projection];
}
