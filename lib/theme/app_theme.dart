import 'package:flutter/material.dart';
import 'package:extra/animations/route_animation.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true, // uses MaterialYou 3
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
      },
    ),
    primarySwatch: Colors.teal,
    errorColor: Colors.pink,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber,
    ),
    primaryColor: Colors.amber,
    canvasColor: const Color.fromRGBO(12, 12, 12, 0.96),
    textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily: 'SourceSansPro',
          ),
          bodyText2: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'SourceSansPro',
          ),
          headline1: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Chilanka',
          ),
          headline2: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontFamily: 'SourceSansPro',
          ),
          headline3: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          headline4: const TextStyle(
            color: Colors.white,
            fontFamily: 'SourceSansPro',
            fontSize: 20.0,
          ),
          headline5: const TextStyle(
            color: Colors.white54,
            fontFamily: 'SourceSansPro',
            fontSize: 13.0,
          ),
          headline6: const TextStyle(
            fontSize: 20,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true, // uses MaterialYou 3
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(),
      },
    ),
    primarySwatch: Colors.teal,
    errorColor: Colors.pink,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber,
    ),
    primaryColor: Colors.amber,
    canvasColor: const Color.fromRGBO(255, 254, 229, 0.96),
    bottomAppBarColor: Colors.teal,
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            fontSize: 17,
            fontFamily: 'SourceSansPro',
          ),
          bodyText2: const TextStyle(
            fontSize: 18,
            fontFamily: 'SourceSansPro',
          ),
          headline1: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Chilanka',
          ),
          headline2: const TextStyle(
            color: Colors.pinkAccent,
            fontSize: 18,
            fontFamily: 'SourceSansPro',
          ),
          headline3: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          headline4: const TextStyle(
            color: Colors.black,
            fontFamily: 'SourceSansPro',
            fontSize: 20.0,
          ),
          headline5: const TextStyle(
            color: Colors.black54,
            fontFamily: 'SourceSansPro',
            fontSize: 13.0,
          ),
          headline6: const TextStyle(
            fontSize: 20,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}
