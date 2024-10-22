
import 'package:flutter/material.dart';

import '../models/film.dart';
import 'film_form.dart';



class UpdateFilmDialog extends StatelessWidget {
  final   Film  film;
  final void Function(Film) onSubmit;

  const UpdateFilmDialog({
    Key? key,
    required this.film,
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
        child: FilmForm(
          initialFilm: film,
          onSubmit: (Film updatedFilm) {
            onSubmit(updatedFilm);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static void show(BuildContext context,  Film film, void Function(Film) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => UpdateFilmDialog(
        film: film,
        onSubmit: onSubmit,
      ),
    );
  }
}
