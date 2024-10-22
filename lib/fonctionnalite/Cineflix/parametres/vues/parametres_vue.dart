
import 'package:cineflix/fonctionnalite/Cineflix/film/film_services/film_reservation_service.dart';
import 'package:cineflix/fonctionnalite/Cineflix/parametres/vues/theme_vue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../utils/constantes/tailles.dart';
import '../../../../utils/helper/fonctions.dart';
import '../../../../utils/helper/secureStorage.dart';
import '../../authentification/blocs/authentification/authentification_bloc.dart';



class ParametresScreen extends StatefulWidget {

  const ParametresScreen (
      {Key? key})
      : super(key: key);

  @override
  _ParametresScreenState createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  String username = '';
  String email ='';
  void _handleLogout() async {
    context
        .read<AuthentificationBloc>()
        .add(const AuthentificationLogoutRequested());
    ReservationService.clearAllReservations();
  }

 void _getInfo()async{
    username = await FuzSecureStorageManager.read('username') ??'Username';
   email = await FuzSecureStorageManager.read('email') ??'Email';
 }

  Widget buildSection(String title, List<Widget> content) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surfaceVariant,
      elevation:3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: content,
        ),
      ),
    );
  }

  Widget buildItem(String title,IconData icon,Widget page){
    return Card(margin: const EdgeInsets.all(4),

      child:ListTile(
        onTap: () {
      Navigator.of(context).push(
        FuzHelperFunctions.createRoute(page),
      );
    },
        leading:Icon(icon) ,
        title:Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium
      ),
        trailing:  Icon(
          Icons.arrow_forward_ios_outlined,
          color: Theme.of(context).colorScheme.outlineVariant,
          size: FuzSizes.iconSm,
        ),
      ),
    );
  }

@override
void initState() {
  // TODO: implement initState
  super.initState();
  _getInfo();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.person_rounded, size: 100,),
                const SizedBox(height: 16),
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),

              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListItem(LineIcons.palette, 'Thème', () {Navigator.of(context).push(
                  FuzHelperFunctions.createRoute(ThemeScreen()),
                );}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton.icon(
              icon: Icon(LineIcons.powerOff, color: Colors.red),
              label: Text('Deconnexion'),
              onPressed: _handleLogout,
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, backgroundColor: Colors.red.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildListItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: onTap,
    );
  }
}
