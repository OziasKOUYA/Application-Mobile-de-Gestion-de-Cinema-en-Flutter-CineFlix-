
import 'package:cineflix/fonctionnalite/Cineflix/salle/vues/salle_form.dart';
import 'package:flutter/material.dart';

import '../models/salle.dart';



class UpdateSalleDialog extends StatelessWidget {
  final   Salle  salle;
  final void Function(Salle) onSubmit;

  const UpdateSalleDialog({
    Key? key,
    required this.salle,
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
        child: SalleForm(
          initialSalle: salle,
          onSubmit: (Salle updatedSalle) {
            onSubmit(updatedSalle);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static void show(BuildContext context,  Salle salle, void Function(Salle) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => UpdateSalleDialog(
        salle: salle,
        onSubmit: onSubmit,
      ),
    );
  }
}
