
import 'package:flutter/material.dart';

import '../models/film.dart';
import 'film_form.dart';





class AddFilmDialog extends StatelessWidget {
  final void Function(Film) onSubmit;

  const AddFilmDialog({super.key, required this.onSubmit});

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
        child: FilmForm(onSubmit: (Film film) {
          onSubmit(film);
          Navigator.pop(context);
        }),
      ),
    );
  }

  static void show(BuildContext context,  void Function(Film) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => AddFilmDialog( onSubmit: onSubmit),
    );
  }
}
