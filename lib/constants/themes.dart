import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_colors.dart';

ThemeData appLiteTheme() {
  return ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: MyColors.light4)),
      iconTheme: IconThemeData(color: MyColors.light4),
      cardTheme: CardTheme(
        color: MyColors.light2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      primaryColor: MyColors.light1,
      hintColor: MyColors.light1,
      scaffoldBackgroundColor: MyColors.light1,
      canvasColor: MyColors.light2,
      primaryTextTheme: TextTheme(headline6: TextStyle(color: MyColors.light4)),
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: MyColors.light4),
        backgroundColor: MyColors.light1,
        foregroundColor: MyColors.light4,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColors.light1,
          statusBarIconBrightness: Brightness.dark,
        )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyColors.light1,
          elevation: 0,
          selectedItemColor: MyColors.light4,
          unselectedItemColor: MyColors.light3),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: MyColors.light4));
}

ThemeData appDarkTheme() {
  return ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: MyColors.dark4)),
      iconTheme: IconThemeData(color: MyColors.dark4),
      cardTheme: CardTheme(
        color: MyColors.dark2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      primaryColor: MyColors.dark1,
      hintColor: MyColors.dark1,
      scaffoldBackgroundColor: MyColors.dark1,
      canvasColor: MyColors.dark2,
      primaryTextTheme: TextTheme(headline6: TextStyle(color: MyColors.dark4) ),
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: MyColors.dark4),
        backgroundColor: MyColors.dark1,
        foregroundColor: MyColors.dark4,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColors.dark1,
            statusBarIconBrightness: Brightness.light,
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: MyColors.dark1,
          elevation: 0,
          selectedItemColor: MyColors.dark4,
          unselectedItemColor: MyColors.dark4.withAlpha(100)),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: MyColors.dark4),
      // inputDecorationTheme:InputDecorationTheme(labelStyle:TextStyle(color: MyColors.dark4))
  );
}
