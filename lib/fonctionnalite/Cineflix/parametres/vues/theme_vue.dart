import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';


class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
 late AdaptiveThemeMode _themeMode ;


  @override
  Widget build(BuildContext context) {
    _themeMode = AdaptiveTheme.of(context).mode;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
          title: const Text('Thème'),
        ),
        body: Column(
          children: <Widget>[
            ListTile(
              leading: Text(
                'Clair',


              ),
              trailing: Radio(
                value: AdaptiveThemeMode.light,
                groupValue: _themeMode,
                onChanged: (AdaptiveThemeMode? value) {
                  setState(() {
                    _themeMode = value!;
                    AdaptiveTheme.of(context).setLight();
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: Text(
                'Sombre',

              ),
              trailing: Radio(
                value: AdaptiveThemeMode.dark,
                groupValue: _themeMode,
                onChanged: (AdaptiveThemeMode? value) {
                  setState(() {
                    _themeMode = value!;
                    AdaptiveTheme.of(context).setDark();
                  });
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: Text(
                'Systeme',
              ),
              trailing: Radio(
                value: AdaptiveThemeMode.system,
                groupValue: _themeMode,
                onChanged: (AdaptiveThemeMode? value) {
                  setState(() {
                    _themeMode = value!;
                    AdaptiveTheme.of(context).setSystem();
                  });
                },
              ),
            ),
            const Divider(),
          ],
        ));
  }
}
