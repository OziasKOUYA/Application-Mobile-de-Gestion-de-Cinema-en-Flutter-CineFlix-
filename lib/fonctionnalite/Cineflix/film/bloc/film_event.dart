part of 'film_bloc.dart';

abstract class FilmEvent extends Equatable {
  const FilmEvent();
}

class LoadFilms extends FilmEvent {

  const LoadFilms();
  @override
  List<Object> get props => [];
}


class AddFilm extends FilmEvent {

  final Film film;

  const AddFilm( this.film);

  @override
  List<Object> get props => [film];
}

class UpdateFilm extends FilmEvent {
  final Film film;

  const UpdateFilm( this.film);

  @override
  List<Object> get props => [film];
}

class DeleteFilm extends FilmEvent {
  final Film film;


  const DeleteFilm( this.film);

  @override
  List<Object> get props => [film];
}
