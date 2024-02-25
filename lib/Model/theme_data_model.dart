import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeDataModel {
  static ThemeData androidThemeData() {
    return ThemeData(
        primarySwatch: Colors.indigo,
        secondaryHeaderColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
            toolbarTextStyle: TextStyle(fontFamily: "OpenSans")));
  }

  static CupertinoThemeData cupertinoThemeData() {
    // ignore: prefer_const_constructors
    return CupertinoThemeData(
      primaryColor: Colors.indigo,
      primaryContrastingColor: Colors.amber,
      textTheme: const CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'Quicksand'),
          navTitleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'OpenSans')),
    );
  }
}
