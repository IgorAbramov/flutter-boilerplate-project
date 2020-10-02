import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/font_family.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final borderRadius = 15.0;

final ThemeData themeDataLight = new ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFF212121),
  primarySwatch: MaterialColor(AppColors.black[100].value, AppColors.black),
  primaryColor: Color(0xFFFFFFFF),
  primaryColorDark: Color(0xFF212121),
  primaryColorLight: Color(0xFFFFFFFF),
  primaryColorBrightness: Brightness.light,
  accentColor: Color(0xFF03A9F4),
  accentColorBrightness: Brightness.light,
  dividerColor: Color(0xFFBDBDBD),
  buttonTheme: ThemeData.light().buttonTheme.copyWith(
        buttonColor: Color(0xFF212121),
        textTheme: ButtonTextTheme.normal,
      ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF212121),
  ),
  bannerTheme: MaterialBannerThemeData(
    backgroundColor: Color(0xFF212121),
  ),
  cardColor: Color(0xFF212121),
  textSelectionColor: Color(0xFF212121),
  indicatorColor: Color(0xFF03A9F4),
  errorColor: Color(0xFFFF5252),
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  primaryColor: Color(0xFF212121),
  primaryColorDark: Color(0xFF212121),
  primaryColorLight: Color(0xFFFFFFFF),
  primaryColorBrightness: Brightness.dark,
  accentColor: Color(0xFF03A9F4),
  accentColorBrightness: Brightness.dark,
  dividerColor: Color(0xFFBDBDBD),
  buttonTheme: ThemeData.dark().buttonTheme.copyWith(
        buttonColor: Color(0xFF212121),
        textTheme: ButtonTextTheme.normal,
      ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF212121),
  ),
  bannerTheme: MaterialBannerThemeData(
    backgroundColor: Color(0xFF212121),
  ),
  cardColor: Color(0xFF212121),
  textSelectionColor: Color(0xFFFFFFFF),
  indicatorColor: Color(0xFF03A9F4),
  errorColor: Color(0xFFFF5252),
);

const TextStyle kHeaderFontStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle kLogoTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 90.0,
);

const TextStyle kHintTextStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle kDateFontStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kInputTextFieldTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kChatSendButtonTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 24.0,
);

const kPersonalPageDataTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter the value.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
