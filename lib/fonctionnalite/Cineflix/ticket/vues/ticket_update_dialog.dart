
import 'package:cineflix/fonctionnalite/Cineflix/ticket/vues/ticket_form.dart';
import 'package:flutter/material.dart';

import '../models/ticket.dart';



class UpdateTicketDialog extends StatelessWidget {
  final   Ticket  ticket;
  final void Function(Ticket) onSubmit;

  const UpdateTicketDialog({
    Key? key,
    required this.ticket,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: TicketForm(
          initialTicket: ticket,
          onSubmit: (Ticket updatedTicket) {
            onSubmit(updatedTicket);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static void show(BuildContext context,  Ticket ticket, void Function(Ticket) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => UpdateTicketDialog(
        ticket: ticket,
        onSubmit: onSubmit,
      ),
    );
  }
}
