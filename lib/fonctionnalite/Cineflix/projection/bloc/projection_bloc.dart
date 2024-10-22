import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/projection.dart';
import '../projection_service.dart';





part 'projection_event.dart';
part 'projection_state.dart';

class ProjectionBloc extends Bloc<ProjectionEvent, ProjectionState> {
  final ProjectionService projectionService;

  ProjectionBloc({required this.projectionService})
      : super(ProjectionLoadInProgress()) {
    on<LoadProjections>(_onProjectionsLoaded);
    on<AddProjection>(_onTicketAdded);
    on<UpdateProjection>(_onProjectionUpdated);
    on<DeleteProjection>(_onProjectionDeleted);
  }



  Future<void> _onProjectionsLoaded(
      LoadProjections event,
      Emitter<ProjectionState> emit,
      ) async {
    try {
      emit(ProjectionLoadInProgress());
      final projections = await projectionService.getProjection();

      emit(ProjectionLoadSuccess(projections));
    } catch (e) {
      emit(ProjectionOperationFailure(e.toString()));
    }
  }

  Future<void> _onTicketAdded(
      AddProjection event,
      Emitter<ProjectionState> emit,
      ) async {
    try {
      emit(ProjectionLoadInProgress());
      await projectionService.addProjection(event.projection);
      final projections = await projectionService.getProjection();
      emit(ProjectionLoadSuccess(projections));
    } catch (e) {
      emit(ProjectionOperationFailure(e.toString()));
    }
  }

  Future<void> _onProjectionUpdated(
      UpdateProjection event,
      Emitter<ProjectionState> emit,
      ) async {
    try {
      emit(ProjectionLoadInProgress());
      await projectionService.updateProjection(event.projection);
      final projections = await projectionService.getProjection();
      emit(ProjectionLoadSuccess(projections));
    } catch (e) {
      emit(ProjectionOperationFailure(e.toString()));
    }
  }

  Future<void> _onProjectionDeleted(
      DeleteProjection event,
      Emitter<ProjectionState> emit,
      ) async {
    try {
      emit(ProjectionLoadInProgress());
      await projectionService.deleteProjection(event.projection);
      final projections = await projectionService.getProjection();
      emit(ProjectionLoadSuccess(projections));
    } catch (e) {
      emit(ProjectionOperationFailure(e.toString()));
    }
  }
}
