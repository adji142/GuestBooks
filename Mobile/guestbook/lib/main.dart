import 'package:flutter/material.dart';
import 'package:guestbook/index.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(134, 138, 205, .1),
      100: Color.fromRGBO(134, 138, 205, .2),
      200: Color.fromRGBO(134, 138, 205, .3),
      300: Color.fromRGBO(134, 138, 205, .4),
      400: Color.fromRGBO(134, 138, 205, .5),
      500: Color.fromRGBO(134, 138, 205, .6),
      600: Color.fromRGBO(134, 138, 205, .7),
      700: Color.fromRGBO(134, 138, 205, .8),
      800: Color.fromRGBO(134, 138, 205, .9),
      900: Color.fromRGBO(134, 138, 205, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF868ACD, color);

    return MaterialApp(
      title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: colorCustom,
        ),
        home: Index()
    );
  }
}