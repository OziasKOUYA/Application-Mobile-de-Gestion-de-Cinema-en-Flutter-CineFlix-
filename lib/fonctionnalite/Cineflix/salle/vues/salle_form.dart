
import 'package:flutter/material.dart';

import '../models/salle.dart';



class SalleForm extends StatefulWidget {
  final Salle? initialSalle;
  final Function(Salle) onSubmit;
  const SalleForm({super.key, this.initialSalle, required this.onSubmit});

  @override
  _SalleFormState createState() => _SalleFormState();
}

class _SalleFormState extends State<SalleForm> {
  late String libelle;
  late int nombre_de_place;




  final TextEditingController libelleController = TextEditingController();
  final TextEditingController nombre_de_placeController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    libelle= widget.initialSalle?.libelle ?? '';
    nombre_de_place = widget.initialSalle?.nombre_de_place ?? 0;
    libelleController.text = libelle;
    nombre_de_placeController.text = nombre_de_place.toString();

  }

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit(Salle(
        libelle: libelle,
        nombre_de_place: nombre_de_place,
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
                    labelText: 'nombre_de_place',
                  ),
                  keyboardType: TextInputType.number,
                  controller: nombre_de_placeController,
                  onChanged: (value) {
                    nombre_de_place = int.tryParse(value) ?? 0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le nombre_de_place est obligatoire';
                    }

                    int enteredValue = int.tryParse(value) ?? 0;

                    if (enteredValue == 0) {
                      return 'Le Le nombre_de_place ne doit pas être égal à zéro';
                    }

                    return null;
                  },
                ),


                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'libelle',
                  ),
                  controller: libelleController,
                  onChanged: (value) {
                    libelle = value;
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
