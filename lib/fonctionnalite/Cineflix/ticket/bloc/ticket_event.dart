part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class LoadTickets extends TicketEvent {

  const LoadTickets();
  @override
  List<Object> get props => [];
}


class AddTicket extends TicketEvent {

  final Ticket ticket;

  const AddTicket( this.ticket);

  @override
  List<Object> get props => [ticket];
}

class UpdateTicket extends TicketEvent {
  final Ticket ticket;

  const UpdateTicket( this.ticket);

  @override
  List<Object> get props => [ticket];
}

class DeleteTicket extends TicketEvent {
  final Ticket ticket;


  const DeleteTicket( this.ticket);

  @override
  List<Object> get props => [ticket];
}
