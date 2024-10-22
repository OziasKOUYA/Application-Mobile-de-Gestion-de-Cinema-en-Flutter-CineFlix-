
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/ticket.dart';

class DetailsTicketBottomSheet extends StatelessWidget {
  final Ticket ticket;

  const DetailsTicketBottomSheet({Key? key, required this.ticket}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                LineIcons.moneyBill,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('numero'),
              subtitle: Text('${ticket.numero}'),
            ),

            ListTile(
              leading: Icon(
                LineIcons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('prix'),
              subtitle: Text('${ticket.prix}'),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('type'),
              subtitle: Text(ticket.type!),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Ticket ticket) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DetailsTicketBottomSheet(ticket: ticket);
      },
    );
  }
}
