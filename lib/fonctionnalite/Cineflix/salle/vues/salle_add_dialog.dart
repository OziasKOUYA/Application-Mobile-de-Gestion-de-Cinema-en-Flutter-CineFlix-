
import 'package:cineflix/fonctionnalite/Cineflix/salle/models/salle.dart';
import 'package:flutter/material.dart';

import 'salle_form.dart';





class AddSalleDialog extends StatelessWidget {
  final void Function(Salle) onSubmit;

  const AddSalleDialog({super.key, required this.onSubmit});

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
        child: SalleForm(onSubmit: (Salle salle) {
          onSubmit(salle);
          Navigator.pop(context);
        }),
      ),
    );
  }

  static void show(BuildContext context,  void Function(Salle) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => AddSalleDialog( onSubmit: onSubmit),
    );
  }
}
