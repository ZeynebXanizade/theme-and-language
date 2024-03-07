import 'package:flutter/material.dart';
import 'package:reservation/src/utils/constants/app_colors.dart';

////////////////////////////DARK THEME///////////////////////////////////////////////////
class ThemesApp {
  static ThemeData dartTheme = ThemeData.dark().copyWith(
      //background
      scaffoldBackgroundColor: dark,
      //text
      textTheme: const TextTheme(
          headlineSmall:
              TextStyle(color: lights, fontSize: 13, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: dark),
          headlineLarge: TextStyle(color: lights, fontSize: 20),
          displayLarge: TextStyle(color: light, fontSize: 30)),
      //dialog
      dialogBackgroundColor: light,
      //button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: dark,
              backgroundColor: light,
              shadowColor: light,
              surfaceTintColor: light)),
      //icon
      iconTheme: const IconThemeData(color: lights),
      //snacbar
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: light, contentTextStyle: TextStyle(color: dark)),
      //floatactionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: darklight, splashColor: light),
      //bottomnavigationppbar
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: darklight),
      //tabbar
      tabBarTheme: const TabBarTheme(
          indicatorColor: lights, unselectedLabelColor: lights, labelColor: lights),
      //popmenu
      popupMenuTheme: const PopupMenuThemeData(
          color: light, textStyle: TextStyle(color: dark)),

      //colorshame
      colorScheme: const ColorScheme.dark(
          background: dark, primary: light, onPrimary: dark , onBackground:darklight ));

  /////////////////////////LIGHT THEME////////////////////////////////////////////////////////////////////////////////////////
  static ThemeData lightTheme = ThemeData.light().copyWith(
      //background
      scaffoldBackgroundColor: lights,
      //text
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
              color: dark, fontSize: 13, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: light),
          headlineLarge: TextStyle(color: dark, fontSize: 20),
          displayLarge: TextStyle(color: dark, fontSize: 30)),
      //dialog
      dialogBackgroundColor: dark,
      //button
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: light,
              backgroundColor: dark,
              shadowColor: light,
              surfaceTintColor: light)),
      //icon
      iconTheme: const IconThemeData(
        color: darklight,
      ),
      //snackbar
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: dark, contentTextStyle: TextStyle(color: light)),
      //floatactionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: lights, splashColor: dark),
      //bottomnavigationppbar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lights,
      ),
      //popmenu
      popupMenuTheme: const PopupMenuThemeData(
          color: dark, textStyle: TextStyle(color: light)),

      //tabbar
      tabBarTheme: const TabBarTheme(
          indicatorColor: dark,
          unselectedLabelColor: dark,
          labelColor: dark),

      //colorshame
      colorScheme: const ColorScheme.light(
          background: light, primary: dark, onPrimary: light , onBackground:light));
  //
}
//973a7a