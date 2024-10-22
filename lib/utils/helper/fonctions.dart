import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'download_save.dart';


class FuzHelperFunctions {

  static Future<void> clearListForKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, []);
  }
  static void showSnackBar(BuildContext context, String message,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
      Text(message),
      backgroundColor:color ,),
    );
  }
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  static Future<void> showImageDialog(BuildContext context, String imageUrl) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          content: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>  Center(
                    child:  AspectRatio(
              aspectRatio: 5.0,
              child:CircularProgressIndicator(),
            ),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(LineIcons.photoVideo),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 50.0,
                          sigmaY: 100.0,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                FileStorage.downloadAndSaveImage(imageUrl);
                              },
                              icon: Icon(LineIcons.download,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the dialog box.
                              },
                              icon: Icon(Icons.close_outlined,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  static Future<void> addToActivityLog(String action, String activityDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> activityLog = prefs.getStringList('activity_log') ?? [];
    String timestamp = DateTime.now().toString();
    String fullActivity = '$timestamp - $action: $activityDetails';
    activityLog.insert(0, fullActivity);
    await prefs.setStringList('activity_log', activityLog);
  }

  static  String formatDateMots(DateTime date) {
    return DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(date);
  }

  static void showAlert(BuildContext context, Widget title, String message, [Function? callback]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: Text(message, textAlign: TextAlign.center,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (callback != null) {
                  callback();
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  static double screenHeight(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.height;
  }

  static double screenWidth(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return screenSize.width;
  }

  static bool isScreenSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 640;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String formatDateDMY(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  }

 static  String formatDate(DateTime date) {
    return DateFormat(' d MMMM yyyy').format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String reduceString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static TextTheme getTextTheme(BuildContext context, {Color? color, FontWeight? fontWeight}) {


    if (screenWidth(context) < 600) {
      return smallScreenTextTheme.copyWith(
        bodyMedium: smallScreenTextTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        bodySmall: smallScreenTextTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
      );
    } else if (screenWidth(context) < 1200) {
      return mediumScreenTextTheme.copyWith(
        bodyMedium: mediumScreenTextTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        bodySmall: mediumScreenTextTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
      );
    } else {
      return largeScreenTextTheme.copyWith(
        bodyMedium: largeScreenTextTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        bodySmall: largeScreenTextTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
      );
    }
  }

  static final TextTheme smallScreenTextTheme = TextTheme(
    headlineSmall: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleSmall: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodySmall: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),
    labelSmall: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
  );

  static final TextTheme mediumScreenTextTheme = TextTheme(
    headlineMedium: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)),
  );

 static const TextTheme largeScreenTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
  );



  static void showToastNoContext(
      String message, {
        Color backgroundColor = Colors.black,
        Color textColor = Colors.white,
      }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
  FToast fToast = FToast();





}
void showToast(BuildContext context, String message, {Color backgroundColor = Colors.black, Color textColor = Colors.white}) {
  final fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () {
            fToast.removeCustomToast();
          },
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
