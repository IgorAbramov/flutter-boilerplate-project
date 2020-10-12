import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
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
  scaffoldBackgroundColor: AppColors.darkGray,
  primarySwatch:
      MaterialColor(AppColors.darkGray.value, AppColors.blackPalette),
  primaryColor: AppColors.white,
  primaryColorDark: AppColors.darkGray,
  primaryColorLight: AppColors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: AppColors.blue,
  accentColorBrightness: Brightness.light,
  dividerColor: AppColors.lightGray,
  buttonTheme: ThemeData.light().buttonTheme.copyWith(
        buttonColor: AppColors.darkGray,
        textTheme: ButtonTextTheme.normal,
      ),
  appBarTheme: AppBarTheme(
    color: AppColors.white,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(),
    headline2: TextStyle(),
    headline3: TextStyle(
      //Headers
      fontSize: Dimens.font_size_headline3,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    headline4: TextStyle(
      fontSize: Dimens.font_size_headline4,
      color: AppColors.black,
    ),
    headline5: TextStyle(),
    headline6: TextStyle(),
    subtitle1: TextStyle(
      //Sender name
      fontSize: Dimens.font_size_subtitle1,
      color: AppColors.black,
    ),
    subtitle2: TextStyle(),
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ),
  bannerTheme: MaterialBannerThemeData(
    backgroundColor: AppColors.darkGray,
  ),
  cardColor: AppColors.darkGray,
  indicatorColor: AppColors.blue,
  errorColor: AppColors.red,
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.darkGray,
  primaryColorDark: AppColors.white,
  primaryColorLight: AppColors.white,
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.blue,
  accentColorBrightness: Brightness.dark,
  dividerColor: AppColors.lightGray,
  buttonTheme: ThemeData.dark().buttonTheme.copyWith(
        buttonColor: AppColors.darkGray,
        textTheme: ButtonTextTheme.normal,
      ),
  appBarTheme: AppBarTheme(
    color: AppColors.darkGray,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(),
    headline2: TextStyle(),
    headline3: TextStyle(
      //Headers
      fontSize: Dimens.font_size_headline3,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    headline4: TextStyle(
      fontSize: Dimens.font_size_headline4,
      color: AppColors.white,
    ),
    headline5: TextStyle(),
    headline6: TextStyle(),
    subtitle1: TextStyle(
      //Sender name
      fontSize: Dimens.font_size_subtitle1,
      color: AppColors.white,
    ),
    subtitle2: TextStyle(),
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ),
  bannerTheme: MaterialBannerThemeData(
    backgroundColor: AppColors.darkGray,
  ),
  cardColor: AppColors.darkGray,
  indicatorColor: AppColors.blue,
  errorColor: AppColors.red,
);

const TextStyle kHeaderFontStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);

const TextStyle kLogoTextStyle = TextStyle(
  color: AppColors.white,
  fontWeight: FontWeight.w900,
  fontSize: 90.0,
);

const TextStyle kHintTextStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.bold,
  color: AppColors.white,
);

const TextStyle kDateFontStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
);

const kInputTextFieldTextStyle = TextStyle(
  color: AppColors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kChatSendButtonTextStyle = TextStyle(
  color: AppColors.black,
  fontWeight: FontWeight.bold,
  fontSize: 24.0,
);

const kPersonalPageDataTextStyle = TextStyle(
  color: AppColors.black,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: AppColors.lightBlue, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter the value.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.white, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
