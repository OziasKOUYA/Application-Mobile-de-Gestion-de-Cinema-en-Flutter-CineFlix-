
import 'package:flutter/material.dart';
import '../models/ticket.dart';


class TicketForm extends StatefulWidget {
  final Ticket? initialTicket;
  final Function(Ticket) onSubmit;
  const TicketForm({super.key, this.initialTicket, required this.onSubmit});

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  late int numero;
  late String type;
  late double prix;


  final TextEditingController numeroController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController prixController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    numero = widget.initialTicket?.numero ?? 0;
    prix = widget.initialTicket?.prix ?? 0.0;
    type = widget.initialTicket?.type ?? '';
    numeroController.text = numero.toString();
    prixController.text = prix.toString();
    typeController.text = type;
  }

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      widget.onSubmit(Ticket(
        numero: numero,
        prix: prix,
        type: type,
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
                    labelText: 'numero',
                  ),
                  keyboardType: TextInputType.number,
                  controller: numeroController,
                  onChanged: (value) {
                    numero = int.tryParse(value) ?? 0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le numero est obligatoire';
                    }

                    int enteredValue = int.tryParse(value) ?? 0;

                    if (enteredValue == 0) {
                      return 'Le numero ne doit pas être égal à zéro';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),
                TextFormField(


                  decoration: const InputDecoration(
                    labelText: 'prix',
                  ),
                  keyboardType: TextInputType.number,
                  controller: prixController,
                  onChanged: (value) {
                    prix = double.tryParse(value) ?? 0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Le prix est obligatoire';
                    }

                    double enteredValue = double.tryParse(value) ?? 0;

                    if (enteredValue == 0) {
                      return 'Le prix ne doit pas être égal à zéro';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'type',
                  ),
                  controller: typeController,
                  onChanged: (value) {
                    type = value;
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
