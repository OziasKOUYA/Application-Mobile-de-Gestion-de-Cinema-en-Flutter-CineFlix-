import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../film_services/film_service.dart';
import '../models/film.dart';




part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmService filmService;

  FilmBloc({required this.filmService})
      : super(FilmLoadInProgress()) {
    on<LoadFilms>(_onFilmsLoaded);
    on<AddFilm>(_onFilmAdded);
    on<UpdateFilm>(_onFilmUpdated);
    on<DeleteFilm>(_onFilmDeleted);
  }



  Future<void> _onFilmsLoaded(
      LoadFilms event,
      Emitter<FilmState> emit,
      ) async {
    try {
      emit(FilmLoadInProgress());
      final films = await filmService.getFilm();

      emit(FilmLoadSuccess(films));
    } catch (e) {
      emit(FilmOperationFailure(e.toString()));
    }
  }

  Future<void> _onFilmAdded(
      AddFilm event,
      Emitter<FilmState> emit,
      ) async {
    try {
      emit(FilmLoadInProgress());
      await filmService.addFilm(event.film);
      final films = await filmService.getFilm();
      emit(FilmLoadSuccess(films));
    } catch (e) {
      emit(FilmOperationFailure(e.toString()));
    }
  }

  Future<void> _onFilmUpdated(
      UpdateFilm event,
      Emitter<FilmState> emit,
      ) async {
    try {
      emit(FilmLoadInProgress());
      await filmService.updateFilm(event.film);
      final films = await filmService.getFilm();
      emit(FilmLoadSuccess(films));
    } catch (e) {
      emit(FilmOperationFailure(e.toString()));
    }
  }

  Future<void> _onFilmDeleted(
      DeleteFilm event,
      Emitter<FilmState> emit,
      ) async {
    try {
      emit(FilmLoadInProgress());
      await filmService.deleteFilm(event.film);
      final films = await filmService.getFilm();
      emit(FilmLoadSuccess(films));
    } catch (e) {
      emit(FilmOperationFailure(e.toString()));
    }
  }
}
