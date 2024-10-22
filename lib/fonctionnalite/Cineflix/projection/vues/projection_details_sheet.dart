
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/projection.dart';



class DetailsProjectionBottomSheet extends StatelessWidget {
  final Projection projection;

  const DetailsProjectionBottomSheet({Key? key, required this.projection}) : super(key: key);


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
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('film'),
              subtitle: Text(projection.film!),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('salle'),
              subtitle: Text(projection.salle!),
            ),

            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('date'),
              subtitle: Text(projection.date!),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('heure'),
              subtitle: Text(projection.heure!),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Projection projection) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DetailsProjectionBottomSheet(projection: projection);
      },
    );
  }
}
