import 'package:flutter/material.dart';

import 'custom_colors.dart';

class CustomTheme with ChangeNotifier {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: CustomColors.lightThemeMenu,
        scaffoldBackgroundColor: CustomColors.lightThemeMainBody,
        canvasColor: CustomColors.lightThemeMenuBar,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.blue)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
         // color: Colors.white,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
            backgroundColor: CustomColors.lightThemeMenu,
            collapsedBackgroundColor: CustomColors.lightThemeMenu,
            textColor: Colors.white,
            collapsedTextColor: Colors.white,
            iconColor: Colors.white,
            collapsedIconColor: Colors.white),
        listTileTheme: ListTileThemeData(
            textColor: Colors.white
        )

    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: CustomColors.darkThemeMenu,
        scaffoldBackgroundColor: Colors.grey,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
        canvasColor: CustomColors.darkThemeMenuBar,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        //  color: CustomColors.darkTextMenuBar,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: CustomColors.darkThemeMenu,
          collapsedBackgroundColor: CustomColors.darkThemeMenu,
          collapsedTextColor: CustomColors.darkTextMenuBar,
          textColor: CustomColors.darkTextMenuBar,
          collapsedIconColor: CustomColors.darkTextMenuBar,
          iconColor: CustomColors.darkTextMenuBar,
        ),
        listTileTheme: ListTileThemeData(
        textColor: CustomColors.darkTextMenuBar
    )
    );
  }

  static ThemeData get warmTheme {
    return ThemeData(
        primaryColor: CustomColors.warmThemeMenu,
        scaffoldBackgroundColor: Colors.greenAccent,
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.deepOrange)),
        canvasColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: CustomColors.warmThemeMenu,
          collapsedBackgroundColor: CustomColors.warmThemeMenu,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
        ),
        listTileTheme: ListTileThemeData(
            textColor: Colors.white
        ),
    );
  }

  static int themeID = 0;

  ThemeMode get currentTheme {
    if (themeID == 0) {
      return ThemeMode.light;
    } else if (themeID == 1) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  void toggleLight() {
    if (themeID != 0) {
      themeID = 0;
      notifyListeners();
    }
  }

  void toggleDark() {
    if (themeID != 1) {
      themeID = 1;
      notifyListeners();
    }
  }

  void toggleWarm() {
    if (themeID != 3) {
      themeID = 3;
      notifyListeners();
    }
  }
}
