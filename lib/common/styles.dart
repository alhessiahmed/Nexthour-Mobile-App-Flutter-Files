import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

/// basic colors
const cStatusBarColor = Color.fromRGBO(20, 20, 20, 1.0);
const cSystemNavigationColor = Color.fromRGBO(20, 20, 20, 1.0);
const primaryBlue = Color.fromRGBO(72, 163, 198, 1.0);
const kTeal50 = Color(0xFFE0F2F1);
const kTeal100 = Color(0xFF3FC1BE);
const kDefaultBackgroundAvatar = '3FC1BE';
const kDefaultTextColorAvatar = 'EEEEEE';
const kDefaultAdminBackgroundAvatar = 'EEEEEE';
const kDefaultAdminTextColorAvatar = '3FC1BE';
const kTeal400 = Color(0xFF26A69A);
const kGrey900 = Color(0xFF141414);
const kGreyColor = Color(0xFFa3a3a3);
const kGrey600 = Color(0xFF546E7A);
const kGrey200 = Color(0xFFEEEEEE);
const kGrey400 = Color(0xFF90a4ae);
const kErrorRed = Color(0xFFe74c3c);
const kSurfaceWhite = Color(0xFFFFFBFA);
const kBackgroundWhite = Color.fromRGBO(255, 255, 255, 1.0);

/// color for theme
const kMainThemeColor = primaryBlue;
const kLightPrimary = Color(0xfffcfcff);
const kLightAccent = Color(0xFF546E7A);
const kLightThemeTextHeading = Color(0xff141414);
const kDarkAccent = Color(0xffF4F5F5);
const kLightBG1 = Color(0xffFFFFFF);
const kLightBG2 = Color(0xffF1F2F3);
const kDarkBG = Color.fromRGBO(34, 34, 34, 1.0);
const kHintColor = Color.fromRGBO(106, 122, 130, 1.0);
const kDarkBgLight = Color(0xff141414);
const kDarkBgDark = Color(0xff101010);
const kDarkTextColor = Color(0xff101010);
const kLightThemeTextColor = Color.fromRGBO(27, 84, 111, 1.0);
const kBadgeColor = Colors.red;
const cardColor = Color.fromRGBO(100, 100, 100, 1.0);
const kProductTitleStyleLarge =
    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

var kTextField = InputDecoration(
  hintText: translate('Enter_your_value'),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(3.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(3.0)),
  ),
);

IconThemeData _customIconTheme1(IconThemeData original) {
  return original.copyWith(color: kLightThemeTextColor);
}

IconThemeData _customIconTheme2(IconThemeData original) {
  return original.copyWith(color: kHintColor);
}

IconThemeData _customIconTheme3(IconThemeData original) {
  return original.copyWith(color: kBackgroundWhite);
}

IconThemeData _customIconTheme4(IconThemeData original) {
  return original.copyWith(color: kGreyColor);
}

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    cardColor: Colors.white,
    errorColor: kErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: kColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryColorLight: kLightBG2,
    primaryColorDark: kLightBG1,
    primaryIconTheme: _customIconTheme1(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme2(base.iconTheme),
    hintColor: kHintColor,
    backgroundColor: Colors.white,
    primaryColor: kMainThemeColor,
    scaffoldBackgroundColor: kLightBG2,
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: kLightAccent,
      ),
      toolbarTextStyle: TextTheme(
        headline6: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        headline6: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).headline6,
    ),
    colorScheme: kColorScheme.copyWith(secondary: kLightThemeTextHeading),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!
            .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
        headline6: base.headline6!.copyWith(fontSize: 18.0),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Raleway',
        displayColor: kGrey900,
        bodyColor: kGrey900,
      )
      .copyWith(headline5: base.headline5!.copyWith(fontFamily: 'Roboto'));
}

const ColorScheme kColorScheme = ColorScheme(
  primary: kTeal100,
  secondary: kTeal50,
  surface: kSurfaceWhite,
  background: kBackgroundWhite,
  error: kErrorRed,
  onPrimary: kGrey900,
  onSecondary: kGrey900,
  onSurface: kGrey900,
  onBackground: kGrey900,
  onError: kSurfaceWhite,
  brightness: Brightness.light,
);

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    cardColor: cardColor,
    brightness: Brightness.dark,
    backgroundColor: kDarkBG,
    primaryColor: kMainThemeColor,
    primaryColorLight: kDarkBgLight,
    primaryColorDark: kDarkBgDark,
    scaffoldBackgroundColor: kDarkBG,
    hintColor: kGreyColor,
    primaryIconTheme: _customIconTheme3(base.iconTheme),
    iconTheme: _customIconTheme4(base.iconTheme),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: kDarkAccent,
      ),
      toolbarTextStyle: TextTheme(
        headline6: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        headline6: TextStyle(
          color: kDarkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).headline6,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kDarkAccent),
  );
}

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kTeal400, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: kTeal400,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

var kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: translate('Type_your_message_here...'),
  border: InputBorder.none,
);
