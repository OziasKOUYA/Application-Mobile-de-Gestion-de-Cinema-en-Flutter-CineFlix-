import 'package:cineflix/fonctionnalite/Cineflix/film/vues/film_reservations_vue.dart';
import 'package:cineflix/fonctionnalite/Cineflix/film/vues/film_vue.dart';
import 'package:flutter/material.dart';

import '../../fonctionnalite/Cineflix/parametres/vues/parametres_vue.dart';
import '../../fonctionnalite/Cineflix/salle/vues/salle_vue.dart';


class FuzNavigation {

  static List<NavigationItem> userNavigationItems = [
    NavigationItem(
      icon: Icons.tv_sharp,
      label: 'Films',
      pageBuilder: () => const FilmScreen()
    ),
    NavigationItem(
        icon: Icons.bookmark_outline,
        label: 'Réservations',
        pageBuilder: () => ReservedFilmsScreen()
    ),
    NavigationItem(
      icon: Icons.person_outline,
      label: 'Profil',
      pageBuilder: () => const ParametresScreen(),
    ),
  ];

  static List<NavigationItem> guestNavigationItems = [
    NavigationItem(
      icon: Icons.home,
      label: 'Home',
      pageBuilder: () =>  const Placeholder(),
    ),

    NavigationItem(
      icon: Icons.settings,
      label: 'Settings',
      pageBuilder: () => const ParametresScreen(),
    ),
  ];


}
class NavigationItem {
  final IconData icon;
  final String label;
  final Widget Function() pageBuilder;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.pageBuilder,
  });
}
