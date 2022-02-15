import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesTheme {
  static const appBarElevation = 0.0;
  static const appBarRaisedElevation = 12.0;
  static const headlineHeight1 = 80.0;
  static const headlineHeight2 = 56.0;
  static const headlineHeight3 = 40.0;
  static const headlineHeight4 = 32.0;
  static const headlineHeight5 = 24.0;
  static const headlineHeight6 = 24.0;

  static const bodyTextHeight1 = 32.0;
  static const bodyTextHeight2 = 24.0;
  static const subtitleHeight1 = 24.0;
  static const subtitleHeight2 = 24.0;

  static const captionHeight = 16.0;

  static const primaryColor = Color(0xFF2bd17e);
  static const backgroundColor = Color(0xff093545);
  static const inputColor = Color(0xff224957);
  static const cardColor = Color(0xff092c39);
  static const errorColor = Color(0xffeb5757);
  static const fontColor = Colors.white;
  static const iconColor = Color(0xFFFFFFFF);

  ThemeData build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.copyWith(
          button: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: fontColor,
              letterSpacing: 0),
          caption: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: fontColor,
              letterSpacing: 0),
          headline1: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 64,
              color: fontColor,
              letterSpacing: 0),
          headline2: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 48,
              color: fontColor,
              letterSpacing: 0),
          headline3: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: fontColor,
              letterSpacing: 0),
          headline4: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: fontColor,
              letterSpacing: 0),
          headline5: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: fontColor,
              letterSpacing: 0),
          headline6: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: fontColor,
              letterSpacing: 0),
          bodyText1: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: fontColor,
              letterSpacing: 0),
          bodyText2: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: fontColor,
              letterSpacing: 0),
          subtitle1: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: fontColor,
              letterSpacing: 0),
          subtitle2: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: fontColor,
              letterSpacing: 0),
        );
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
            hintStyle: textTheme.bodyText2,
            fillColor: inputColor,
            labelStyle: textTheme.bodyText2,
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Color(0xff224957)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Color(0xff224957)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xffeb5757)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xffeb5757)),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
      textTheme: GoogleFonts.montserratTextTheme(textTheme),
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        height: 22,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          primary: primaryColor,
          textStyle: const TextStyle(
            color: fontColor,
          ),
          minimumSize: const Size.fromHeight(50),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: backgroundColor,
          textStyle: Theme.of(context).textTheme.overline?.apply(
                color: fontColor,
              ),
        ),
      ),
      splashColor: backgroundColor,
      primaryColorLight: backgroundColor,
      secondaryHeaderColor: backgroundColor,
    );
  }
}
