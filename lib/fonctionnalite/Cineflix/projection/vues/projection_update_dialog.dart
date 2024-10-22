

import 'package:flutter/material.dart';

import '../models/projection.dart';
import 'projection_form.dart';




class UpdateProjectionDialog extends StatelessWidget {
  final   Projection  projection;
  final void Function(Projection) onSubmit;

  const UpdateProjectionDialog({
    Key? key,
    required this.projection,
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
        child: ProjectionForm(
          initialProjection: projection,
          onSubmit: (Projection updatedProjection) {
            onSubmit(updatedProjection);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static void show(BuildContext context,  Projection projection, void Function(Projection) onSubmit) {
    showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) => UpdateProjectionDialog(
        projection: projection,
        onSubmit: onSubmit,
      ),
    );
  }
}
