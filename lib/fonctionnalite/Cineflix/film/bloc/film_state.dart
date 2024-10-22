part of 'film_bloc.dart';

abstract class FilmState extends Equatable {
  const FilmState();
}

class FilmInitial extends FilmState {
  @override
  List<Object> get props => [];
}

class FilmLoadInProgress extends FilmState {
  @override
  List<Object> get props => [];
}

class FilmLoadSuccess extends FilmState {
  final List<Film> films;

  const FilmLoadSuccess(this.films);

  @override
  List<Object> get props => [films];
}


class FilmOperationFailure extends FilmState {
  final String error;

  const FilmOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
