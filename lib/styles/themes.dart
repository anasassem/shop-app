import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';


ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
  backgroundColor: HexColor("333739"),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("333739"),
        statusBarIconBrightness: Brightness.light),
    backgroundColor: HexColor("333739"),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor("333739"),
      type: BottomNavigationBarType.fixed,
      elevation: 20,
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultClr),
  scaffoldBackgroundColor: HexColor("333739"),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: defaultClr
  )
);

ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
    color: Colors.white,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: defaultClr),
  scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: defaultClr
    )
);