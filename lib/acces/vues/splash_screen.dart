import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Cine',
                        style: GoogleFonts.pompiere(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.surface
                        ),),
                      Text('flix',
                        style: GoogleFonts.inspiration(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 48,
                            color: Theme.of(context).colorScheme.surface
                        ),)
                    ],),
                ) ,


                CircularProgressIndicator(color:Theme.of(context).colorScheme.onPrimary,)
              ],
            ),
    );
  }
}