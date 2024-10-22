part of 'salle_bloc.dart';


abstract class SalleEvent extends Equatable {
  const SalleEvent();
}

class LoadSalles extends SalleEvent {

  const LoadSalles();
  @override
  List<Object> get props => [];
}


class AddSalle extends SalleEvent {

  final Salle salle;

  const AddSalle( this.salle);

  @override
  List<Object> get props => [salle];
}

class UpdateSalle extends SalleEvent {
  final Salle salle;

  const UpdateSalle( this.salle);

  @override
  List<Object> get props => [salle];
}

class DeleteSalle extends SalleEvent {
  final Salle salle;


  const DeleteSalle( this.salle);

  @override
  List<Object> get props => [salle];
}
