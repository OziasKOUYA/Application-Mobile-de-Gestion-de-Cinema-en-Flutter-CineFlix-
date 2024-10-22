import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../fonctionnalite/Cineflix/authentification/vues/connexion_vue.dart';
import '../../utils/constantes/navigationItems.dart';
import '../../utils/helper/fonctions.dart';



class HomeGuestScreen extends StatefulWidget {
  const HomeGuestScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeGuestScreen());
  }

  @override
  State<HomeGuestScreen> createState() => _HomeGuestScreenState();
}

class _HomeGuestScreenState extends State<HomeGuestScreen> {
  int currentIndex = 0;
  final List<Widget> _pages =  FuzNavigation.guestNavigationItems.map((item) => item.pageBuilder()).toList();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = FuzHelperFunctions.isScreenSmall(context);
    if (isSmallScreen) {
      // Render BottomNavigationBar for small screens
      return Scaffold(
          appBar: AppBar(
            title:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Cine',
                  style: GoogleFonts.pompiere(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.primary
                  ),),
                Text('flix',
                  style: GoogleFonts.inspiration(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 48,
                      color: Theme.of(context).colorScheme.primary
                  ),)
              ],) ,

          ),
          body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Center(
               child: FilledButton(
                    onPressed:(){
                      Navigator.of(context).push(
                          FuzHelperFunctions.createRoute(ConnexionScreen())
                      );
                    },
                    child: const Text("Connexion")),
             ),
          ],)
      );
         /* bottomNavigationBar:NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            destinations: FuzNavigation.baseNavigationItems.map((item) => NavigationDestination(
              icon: Icon(item.icon),
              label: item.label,
            )).toList(),
          ));*/
    } else {
      // Render NavigationRail for large screens
      return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              NavigationRail(
                leading: Column(children: [
                  const Icon(Icons.notifications_none_rounded),
                  CircleAvatar(child: Icon(Icons.person_outline_outlined)),
                ]),
                labelType: NavigationRailLabelType.all,
                selectedIndex: currentIndex,
                onDestinationSelected: ( index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                destinations: FuzNavigation.guestNavigationItems.map((item) => NavigationRailDestination(
                  icon: Icon(item.icon),
                  label: Text(item.label),
                )).toList(),
              ),
              Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
        ),
      );
    }

  }

}
