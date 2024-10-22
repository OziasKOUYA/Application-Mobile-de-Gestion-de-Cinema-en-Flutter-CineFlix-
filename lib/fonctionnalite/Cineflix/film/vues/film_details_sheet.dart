
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../models/film.dart';



class DetailsFilmBottomSheet extends StatelessWidget {
  final Film film;

  const DetailsFilmBottomSheet({Key? key, required this.film}) : super(key: key);


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
              title: const Text('affiche'),
              subtitle: Text(film.affiche!),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('titre'),
              subtitle: Text(film.titre!),
            ),

            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('description'),
              subtitle: Text(film.description!),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('acteur_principal'),
              subtitle: Text(film.acteur_principal!),
            ),
            ListTile(
              leading: Icon(
                LineIcons.comment,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('duree'),
              subtitle: Text(film.duree!),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Film film) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DetailsFilmBottomSheet(film: film);
      },
    );
  }
}
