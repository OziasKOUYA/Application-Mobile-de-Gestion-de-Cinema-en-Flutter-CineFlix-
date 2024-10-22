
import 'package:flutter/material.dart';

import '../models/projection.dart';


class ProjectionForm extends StatefulWidget {
  final Projection? initialProjection;
  final Function(Projection) onSubmit;
  const ProjectionForm({super.key, this.initialProjection, required this.onSubmit});

  @override
  _ProjectionFormState createState() => _ProjectionFormState();
}

class _ProjectionFormState extends State<ProjectionForm> {
  late String film;
  late String salle;
  late String date;
  late String heure;


  final TextEditingController filmController = TextEditingController();
  final TextEditingController salleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController heureController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    film = widget.initialProjection?.film ?? '';
    salle = widget.initialProjection?.salle ?? '';
    date = widget.initialProjection?.date ?? '';
    heure = widget.initialProjection?.heure ?? '';
    filmController.text = film;
    salleController.text = salle;
    dateController.text = date;
    heureController.text = heure;
  }

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit(Projection(
        film: film,
        salle: salle,
        date: date,
        heure: heure,
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
                    labelText: 'film',
                  ),
                  controller: filmController,
                  onChanged: (value) {
                    film = value;
                  },
                ),

                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'salle',
                  ),
                  controller: salleController,
                  onChanged: (value) {
                    salle = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'date',
                  ),
                  controller: dateController,
                  onChanged: (value) {
                    date = value;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'heure',
                  ),
                  controller: heureController,
                  onChanged: (value) {
                    heure = value;
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
