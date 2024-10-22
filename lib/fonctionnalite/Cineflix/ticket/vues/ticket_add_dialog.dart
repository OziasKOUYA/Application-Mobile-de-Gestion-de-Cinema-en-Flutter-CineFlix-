
import 'package:cineflix/fonctionnalite/Cineflix/ticket/models/ticket.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/vues/ticket_form.dart';
import 'package:flutter/material.dart';





class AddTicketDialog extends StatelessWidget {
  final void Function(Ticket) onSubmit;

  const AddTicketDialog({super.key, required this.onSubmit});

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
        child: TicketForm(onSubmit: (Ticket ticket) {
          onSubmit(ticket);
          Navigator.pop(context);
        }),
      ),
    );
  }

  static void show(BuildContext context,  void Function(Ticket) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => AddTicketDialog( onSubmit: onSubmit),
    );
  }
}
