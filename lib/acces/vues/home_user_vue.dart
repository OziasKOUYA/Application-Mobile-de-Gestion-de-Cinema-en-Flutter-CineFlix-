import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constantes/navigationItems.dart';
import '../../utils/constantes/tailles.dart';
import '../../utils/helper/fonctions.dart';


class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeUserScreen());
  }


  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  int currentIndex = 0;
  final List<Widget> _pages =  FuzNavigation.userNavigationItems.map((item) => item.pageBuilder()).toList();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = FuzHelperFunctions.isScreenSmall(context);
    if (isSmallScreen) {
      // Render BottomNavigationBar for small screens
      return Scaffold(
          appBar: AppBar(
            title: Row(
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
            toolbarHeight: FuzSizes.appBarHeightSm,
          ),
          body: IndexedStack(
            index: currentIndex,
            children: _pages,
          ),
          bottomNavigationBar:NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            destinations: FuzNavigation.userNavigationItems.map((item) => NavigationDestination(
              icon: Icon(item.icon),
              label: item.label,
            )).toList(),
          ));
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
                destinations: FuzNavigation.userNavigationItems.map((item) => NavigationRailDestination(
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
