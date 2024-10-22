
import 'package:flutter/material.dart';

import '../models/film.dart';



class FilmForm extends StatefulWidget {
  final Film? initialFilm;
  final Function(Film) onSubmit;
  const FilmForm({super.key, this.initialFilm, required this.onSubmit});

  @override
  _FilmFormState createState() => _FilmFormState();
}

class _FilmFormState extends State<FilmForm> {
  late String affiche;
  late String titre;
  late String description;
  late String acteur_principal;
  late String duree;


  final TextEditingController afficheController = TextEditingController();
  final TextEditingController titreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController acteur_principalController = TextEditingController();
  final TextEditingController dureeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    affiche = widget.initialFilm?.affiche ?? '';
    titre = widget.initialFilm?.titre ?? '';
    description = widget.initialFilm?.description ?? '';
    acteur_principal = widget.initialFilm?.acteur_principal ?? '';
    duree = widget.initialFilm?.duree ?? '';
    afficheController.text = affiche;
    titreController.text = titre;
    descriptionController.text = description;
    acteur_principalController.text = acteur_principal;
    dureeController.text = description;
  }

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit(Film(
        affiche: affiche,
        titre: titre,
        description: description,
        acteur_principal: acteur_principal,
        duree: duree,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'affiche',
                  ),
                  controller: afficheController,
                  onChanged: (value) {
                    affiche = value;
                  },
                ),



                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'titre',
                  ),
                  controller: titreController,
                  onChanged: (value) {
                    titre = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'description',
                  ),
                  controller: descriptionController,
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'acteur_principal',
                  ),
                  controller: acteur_principalController,
                  onChanged: (value) {
                    acteur_principal = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'duree',
                  ),
                  controller: dureeController,
                  onChanged: (value) {
                    duree = value;
                  },
                ),
                const SizedBox(height: 16),


                FilledButton(
                  onPressed: _validateAndSubmit,
                  child: const Text('Envoyer'),
                ),
              ],
            ),
          ),
        )
    );
  }
}
