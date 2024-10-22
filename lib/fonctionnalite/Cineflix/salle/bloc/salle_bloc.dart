import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/models/salle.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Salle_service.dart';




part 'salle_event.dart';
part 'salle_state.dart';

class SalleBloc extends Bloc<SalleEvent, SalleState> {
  final SalleService salleService;

  SalleBloc({required this.salleService})
      : super(SalleLoadInProgress()) {
    on<LoadSalles>(_onSallesLoaded);
    on<AddSalle>(_onSalleAdded);
    on<UpdateSalle>(_onSalleUpdated);
    on<DeleteSalle>(_onSalleDeleted);
  }



  Future<void> _onSallesLoaded(
      LoadSalles event,
      Emitter<SalleState> emit,
      ) async {
    try {
      emit(SalleLoadInProgress());
      final salles = await salleService.getSalles();

      emit(SalleLoadSuccess(salles));
    } catch (e) {
      emit(SalleOperationFailure(e.toString()));
    }
  }

  Future<void> _onSalleAdded(
      AddSalle event,
      Emitter<SalleState> emit,
      ) async {
    try {
      emit(SalleLoadInProgress());
      await salleService.addSalle(event.salle);
      final salles = await salleService.getSalles();
      emit(SalleLoadSuccess(salles));
    } catch (e) {
      emit(SalleOperationFailure(e.toString()));
    }
  }

  Future<void> _onSalleUpdated(
      UpdateSalle event,
      Emitter<SalleState> emit,
      ) async {
    try {
      emit(SalleLoadInProgress());
      await salleService.updateSalle(event.salle);
      final salles = await salleService.getSalles();
      emit(SalleLoadSuccess(salles));
    } catch (e) {
      emit(SalleOperationFailure(e.toString()));
    }
  }

  Future<void> _onSalleDeleted(
      DeleteSalle event,
      Emitter<SalleState> emit,
      ) async {
    try {
      emit(SalleLoadInProgress());
      await salleService.deleteSalle(event.salle);
      final salles = await salleService.getSalles();
      emit(SalleLoadSuccess(salles));
    } catch (e) {
      emit(SalleOperationFailure(e.toString()));
    }
  }
}
