
import 'package:cineflix/fonctionnalite/Cineflix/projection/models/projection.dart';
import 'package:cineflix/fonctionnalite/Cineflix/projection/vues/projection_form.dart';
import 'package:flutter/material.dart';





class AddProjectionDialog extends StatelessWidget {
  final void Function(Projection) onSubmit;

  const AddProjectionDialog({super.key, required this.onSubmit});

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
        child: ProjectionForm(onSubmit: (Projection Projection) {
          onSubmit(Projection);
          Navigator.pop(context);
        }),
      ),
    );
  }

  static void show(BuildContext context,  void Function(Projection) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => AddProjectionDialog( onSubmit: onSubmit),
    );
  }
}
