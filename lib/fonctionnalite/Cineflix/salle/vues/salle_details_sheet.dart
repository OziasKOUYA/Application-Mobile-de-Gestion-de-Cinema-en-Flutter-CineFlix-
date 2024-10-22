
import 'package:cineflix/fonctionnalite/Cineflix/salle/models/salle.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class DetailsSalleBottomSheet extends StatelessWidget {
  final Salle salle;

  const DetailsSalleBottomSheet({Key? key, required this.salle}) : super(key: key);


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
              title: const Text('nombre_de_place'),
              subtitle: Text('${salle.nombre_de_place}'),
            ),

            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('libelle'),
              subtitle: Text(salle.libelle!),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Salle salle) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DetailsSalleBottomSheet(salle: salle);
      },
    );
  }
}
