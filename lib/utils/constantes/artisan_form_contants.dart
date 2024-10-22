
import 'dart:convert';

import 'package:flutter/services.dart';

class ArtisanFormContants {

  static const List<Map<String, String>> typeArtisans = [
    {
      'value': 'B1',
      'label': 'Agroalimentaire, alimentation, petite restauration'
    },
    {'value': 'B2', 'label': 'Mines et carrières, construction et bâtiment'},
    {
      'value': 'B3',
      'label': 'Fabrication métallique, mécanique, électromécanique'
    },
    {'value': 'B4', 'label': 'Bois et assimilés, mobilier et ameublement'},
    {'value': 'B5', 'label': 'Textile, habillement, cuirs et peaux'},
    {'value': 'B6', 'label': 'Audiovisuel et communication'},
    {'value': 'B7', 'label': 'Hygiène et soins corporels'},
    {'value': 'B8', 'label': "Artisanat d'art"},
    {'value': 'aucun', 'label': 'Aucun'},
  ];
  static const List<Map<String, String>> activites = [
    {'value': 'commerce', 'label': 'Commerce'},
    {'value': 'prestation', 'label': 'Prestation'}
  ];

  static Future<List<String>> loadCommunes() async {
    String jsonString = await rootBundle.loadString('assets/ressources_inscription/communes.json');
    return List<String>.from(json.decode(jsonString));
  }

  static const List<Map<String, String>> statutJuridiques = [
    {'value': 'societe', 'label': 'Société'},
    {'value': 'entreprise_individuelle', 'label': 'Entreprise Individuelle'},
    {'value': 'neant', 'label': 'Néant'},
  ];

  static const List<Map<String, String>> regimesFiscales = [
    {'value': 'tpu_declaratif', 'label': 'TPU déclaratif'},
    {'value': 'tpu_forfetaire', 'label': 'TPU forfétaire'},
    {'value': 'reel_avec_TVA', 'label': 'Réel avec TVA'},
    {'value': 'reel_sans_TVA', 'label': 'Réel sans TVA'},
    {'value': 'neant', 'label': 'Néant'},
  ];


}

