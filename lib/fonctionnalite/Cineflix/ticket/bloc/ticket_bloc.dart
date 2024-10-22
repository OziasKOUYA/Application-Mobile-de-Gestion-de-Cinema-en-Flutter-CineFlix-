import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/models/ticket.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ticket_service.dart';



part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final TicketService ticketService;

  TicketBloc({required this.ticketService})
      : super(TicketLoadInProgress()) {
    on<LoadTickets>(_onTicketsLoaded);
    on<AddTicket>(_onTicketAdded);
    on<UpdateTicket>(_onTicketUpdated);
    on<DeleteTicket>(_onTicketDeleted);
  }



  Future<void> _onTicketsLoaded(
      LoadTickets event,
      Emitter<TicketState> emit,
      ) async {
    try {
      emit(TicketLoadInProgress());
      final tickets = await ticketService.getTickets();

      emit(TicketLoadSuccess(tickets));
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

  Future<void> _onTicketAdded(
      AddTicket event,
      Emitter<TicketState> emit,
      ) async {
    try {
      emit(TicketLoadInProgress());
      await ticketService.addTicket(event.ticket);
      final tickets = await ticketService.getTickets();
      emit(TicketLoadSuccess(tickets));
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

  Future<void> _onTicketUpdated(
      UpdateTicket event,
      Emitter<TicketState> emit,
      ) async {
    try {
      emit(TicketLoadInProgress());
      await ticketService.updateTicket(event.ticket);
      final tickets = await ticketService.getTickets();
      emit(TicketLoadSuccess(tickets));
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }

  Future<void> _onTicketDeleted(
      DeleteTicket event,
      Emitter<TicketState> emit,
      ) async {
    try {
      emit(TicketLoadInProgress());
      await ticketService.deleteTicket(event.ticket);
      final tickets = await ticketService.getTickets();
      emit(TicketLoadSuccess(tickets));
    } catch (e) {
      emit(TicketOperationFailure(e.toString()));
    }
  }
}
