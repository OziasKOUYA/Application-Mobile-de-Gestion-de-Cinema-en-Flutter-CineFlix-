part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();
}

class TicketInitial extends TicketState {
  @override
  List<Object> get props => [];
}

class TicketLoadInProgress extends TicketState {
  @override
  List<Object> get props => [];
}

class TicketLoadSuccess extends TicketState {
  final List<Ticket> tickets;

  const TicketLoadSuccess(this.tickets);

  @override
  List<Object> get props => [tickets];
}


class TicketOperationFailure extends TicketState {
  final String error;

  const TicketOperationFailure(this.error);

  @override
  List<Object> get props => [error];
}
