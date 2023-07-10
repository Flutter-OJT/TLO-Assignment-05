import 'package:flutter/material.dart';

class CommonWidget {
  static MaterialColor appColors = const MaterialColor(
    0xff6a1b9a, // Set the primary color to a violet shade
    <int, Color>{
      50: Color(0xfff3e5f5),
      100: Color(0xffe1bee7),
      200: Color(0xffce93d8),
      300: Color(0xffba68c8),
      400: Color(0xffab47bc),
      500: Color(0xff9c27b0), // Adjusted to a violet shade
      600: Color(0xff8e24aa),
      700: Color(0xff7b1fa2),
      800: Color(0xff6a1b9a), // Adjusted to a violet shade
      900: Color(0xff4a148c),
    },
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.purple,
    // Set the primary color to violet
    colorScheme: ColorScheme.fromSwatch(primarySwatch: CommonWidget.appColors),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: appColors),
      bodyLarge: TextStyle(color: appColors),
      bodyMedium: TextStyle(color: appColors),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: CommonWidget.appColors,
      ),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: CommonWidget.appColors,
        fontSize: 18,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      // contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: CommonWidget.appColors,
        ),
      ),
    ),
    drawerTheme: const DrawerThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)))),
  );

  static ButtonStyle primaryButtonStyle({Color? backgroundColor}) =>
      ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: backgroundColor,
      );

  /// The secondary button style
  static ButtonStyle secondaryButtonStyle() => ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black38,
      );

  /// The secondary button style
  static ButtonStyle dangerButtonStyle() => ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
      );
  static IconButton commonIconButton({
    required VoidCallback onPressed,
    required IconData icon,
    double size = 20.0,
    EdgeInsets padding = const EdgeInsets.all(8.0),
    Color backgroundColor = Colors.blue,
    Color iconColor = Colors.white,
  }) {
    return IconButton(
      onPressed: onPressed,
      color: iconColor,
      icon: Icon(icon),
      iconSize: size,
      padding: padding,
    );
  }

  /// The basic input style
  static InputDecoration inputStyle({String? placeholder}) => InputDecoration(
        hintText: placeholder ?? "Enter text",
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CommonWidget.appColors,
          ),
        ),
      );

  /// The basic input style
  static InputDecoration passwordStyle({
    String? placeholder,
    bool? isShow,
    VoidCallback? onShow,
  }) =>
      InputDecoration(
        hintText: placeholder ?? "Enter text",
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
        suffix: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: IconButton(
            onPressed: onShow,
            iconSize: 20,
            color: appColors,
            icon: Icon(isShow != null && isShow
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonWidget.appColors),
        ),
      );

  /// The default title text style
  static TextStyle titleText({Color? color}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: color);

  static TextStyle secondaryTitleText({Color? color}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color);
}
