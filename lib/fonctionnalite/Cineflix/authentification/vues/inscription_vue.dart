import 'dart:async';

import 'package:cineflix/fonctionnalite/Cineflix/authentification/vues/inscription_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/helper/fonctions.dart';



class InscriptionScreen extends StatefulWidget {
  InscriptionScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen>
     {



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isSmallScreen = FuzHelperFunctions.isScreenSmall(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Inscription'),

        centerTitle: true,
      ),
      body: Column(children: [
        InscriptionForm()
      ]),
    );
  }
}
