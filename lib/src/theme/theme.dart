import 'package:flutter/material.dart';

final ThemeData whiteTheme = _buildDefaultTheme();

final red = const Color(0xffEB5757);
final grayish = const Color(0xffD4D4D4);
final curiousBlue = const Color(0xff2D9CDB);
final white = const Color(0xffffffff);
final black = const Color(0xFF000000);
final indigo = const Color(0xFF4957F4);
final splashColor = const Color(0x224957F4);
final brand = const Color(0xFF996D17);
final divider = const Color(0xFFCFCFCF);
final settingsGrey = const Color.fromRGBO(149, 157, 173, 0.56);
final screenGrey = const Color(0xFFF6F6F6);
final grey = const Color.fromARGB(143, 149, 157, 173);
final lightGrey = const Color(0xFFCFCFCF);
final darkGrey = const Color(0xFF4A4A4A);
final profileContainer = const Color(0xFFCACDD6);
final accent = const Color(0xFF454F63);
final appBarBackgroundColor = const Color(0xFFf7f8fb);
final dividerColor = const Color(0xFF959dad);
final settingsTextColor = const Color(0xFF6a7791);
final backgroundColor = const Color(0xFFDCDCDC);
final photoBackground = const Color(0xFFB4BACA);
final keyboardColor = const Color(0xFF959DAD);
final darkestGrey = const Color(0xFF404040);
final textGrey = const Color(0xFF959DAD);
final errorRed = const Color(0xFFE75B52);
final themeShadowColor = const Color(0x4F000000);
final pageBackground = const Color(0xFFF5F5F5);
final placeholderGrey = const Color(0xFFefefef);
final darkBlue = const Color(0xFF1D2E3E);
final lightBlue = const Color(0xFF78849E);
final pink = const Color(0xFFFA709A);
final yellow = const Color(0xFFFEE140);
final textColor = const Color(0xFF6A7791);
final dateText = const Color(0xFF9B51E0);
final crusheeText = const Color(0xFFFF8282);
final toastColor = const Color(0xFF8F8F8F);
final redError = const Color(0xFFBb0000);
final locationBackgroundColor = const Color(0xFFE5E5E5);
final locationButtonColor = const Color(0xFF2D9CDB);
final textFieldHintTextColor = const Color(0xFFC3C8D1);
final resendColor = const Color(0xFF828282);
final boxColor = const Color(0xFFE0E0E0);
final inactiveDot = const Color(0xFFFAACC4);
final dividerColor2 = const Color(0xFFDADADA);
final toastSuccessColor = const Color(0xFF6FCF97);
final dividerColor3 = const Color(0xFFBDBDBD);
final gray = const Color(0xFF828282);
final grayGradient = LinearGradient(
  colors: [
    Color(0xFF828282),
    Color(0xFF828282),
  ],
  begin: FractionalOffset(0.5, 0.0),
  end: FractionalOffset(0.5, 1.0),
);

final appGradient = LinearGradient(
  colors: [
    Color(0xFFFA709A),
    Color(0xFF2D9CDB),
  ],
  begin: FractionalOffset(0.5, 0.0),
  end: FractionalOffset(0.5, 1.0),
);

final reversedGradient = LinearGradient(
  colors: [
    Color(0xFF2D9CDB),
    Color(0xFFFA709A),
  ],
  begin: FractionalOffset(0.5, 0.0),
  end: FractionalOffset(0.5, 1.0),
);

final sCrushGradient = LinearGradient(
  colors: [
    Color(0xFF2D9CDB),
    Color(0xFFFA709A),
  ],
  begin: FractionalOffset(0.0, 0.0),
  end: FractionalOffset(0.0, 1.0),
);

final messageGradient = LinearGradient(
  colors: [
    Color(0xFFFA709A),
    Color(0xFF2D9CDB),
  ],
  begin: FractionalOffset(1.0, 0.5),
  end: FractionalOffset(0.0, 0.5),
);

final dateGradient = LinearGradient(
  colors: [
    Color(0xFF9B51E0),
    Color(0xFF9B51E0),
  ],
  begin: FractionalOffset(0.5, 0.0),
  end: FractionalOffset(0.5, 1.0),
);

final crusheeGradient = LinearGradient(
  colors: [
    crusheeText,
    crusheeText,
  ],
  begin: FractionalOffset(0.5, 0.0),
  end: FractionalOffset(0.5, 1.0),
);

final transparentGradient = LinearGradient(
  colors: [
    Color(0x00000000),
    Color(0x00000000),
  ],
);

final errorGradient = LinearGradient(
  colors: [
    errorRed,
    errorRed,
  ],
);

final greyGradient = LinearGradient(
  colors: [
    Colors.grey,
    Colors.grey,
  ],
);

final buttonPrimaryFillColor = indigo;

final fontFamily = 'Calibre_R';
final baseLineHeight = 1.1;

/// ThemePadding class is a organizational structure that gives developers a simple,
/// reusable set of values and helpers
class ThemePadding {
  static const small = 4.0;
  static const medium = 8.0;
  static const large = 16.0;
  static const xl = 24.0;

  /// This is the basic padding that is used for items in a list.
  static const insetPrimary = EdgeInsets.symmetric(
    horizontal: large,
    vertical: medium,
  );

  /// Horizontal and vertical only EdgeInsets
  static const insetHorizontalSmall = EdgeInsets.symmetric(horizontal: small);
  static const insetHorizontalMedium = EdgeInsets.symmetric(horizontal: medium);
  static const insetHorizontalLarge = EdgeInsets.symmetric(horizontal: large);
  static const insetVerticalSmall = EdgeInsets.symmetric(vertical: small);
  static const insetVerticalMedium = EdgeInsets.symmetric(vertical: medium);
  static const insetVerticalLarge = EdgeInsets.symmetric(vertical: large);

  /// A unified amount of inset is often used for inner padding on containers.
  static const insetAllSmall = EdgeInsets.all(small);
  static const insetAllMedium = EdgeInsets.all(medium);
  static const insetAllLarge = EdgeInsets.all(large);

  ///Floating Action Buttons are offset slightly from the bottom of the page for better iPhone X alignment
  static const fab = EdgeInsets.zero;
}

class TextBox {
  static InputDecoration decoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: accent),
      ),
    );
  }
}

/// [BorderRadius] values
class ThemeBorder {
  static const smallButtonRadius = 4.0;
  static const cardRadiusMedium = 6.0;
  static const cardRadiusLarge = 10.0;
  static const buttonRadius = 36.0;
}

class ThemeShadow {
  static const base = 4.0;

  static const small = BoxShadow(
    blurRadius: 2,
    offset: Offset(0, 1),
    color: Color(0x22000000),
  );

  static const basic = BoxShadow(
    blurRadius: 3,
    offset: Offset(0, 1),
    color: Color.fromRGBO(0, 0, 0, 0.18),
  );

  static const big = BoxShadow(
    color: Color(0x20000000),
    blurRadius: base * 2,
    offset: Offset(0, 1),
  );
}

final double listCellHeight = 72;

ThemeData _buildDefaultTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: indigo,
      errorColor: errorRed,
      accentColor: accent,
      //   splashColor: splashColor,
      sliderTheme: SliderThemeData(
        thumbColor: indigo,
        activeTrackColor: indigo,
        inactiveTrackColor: Color(0xFFE0E2FD),
        activeTickMarkColor: white,
      ),
      cardTheme: CardTheme(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeBorder.cardRadiusLarge),
        ),
      ),
      fontFamily: fontFamily,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xfff8f8f8),
      ),
      textTheme: TextTheme(
        subhead: TextStyle(
          fontSize: 18.0,
          color: accent,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
          height: baseLineHeight,
          fontWeight: FontWeight.w500,
        ),
        display4: TextStyle(
          fontSize: 44.0,
          color: accent,
          fontFamily: fontFamily,
          letterSpacing: -0.3,
          height: baseLineHeight - 0.25,
          fontWeight: FontWeight.w500,
        ),
        display3: TextStyle(
          fontSize: 40.0,
          color: accent,
          fontFamily: fontFamily,
          letterSpacing: -1,
          height: baseLineHeight - 0.25,
          fontWeight: FontWeight.w500,
        ),
        display2: TextStyle(
          fontSize: 34.0,
          color: accent,
          height: baseLineHeight - 0.25,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
        ),
        display1: TextStyle(
          fontSize: 28.0,
          color: accent,
          height: baseLineHeight - 0.25,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
        ),
        headline: TextStyle(
          fontSize: 20.0,
          color: accent,
          letterSpacing: -0.1,
          fontFamily: fontFamily,
          height: baseLineHeight - 0.25,
          fontWeight: FontWeight.w500,
        ),
        body1: TextStyle(
          fontSize: 16.0,
          color: accent,
          fontFamily: fontFamily,
          height: baseLineHeight,
          fontWeight: FontWeight.w500,
        ),
        body2: TextStyle(
          fontSize: 14.0,
          color: accent,
          fontFamily: fontFamily,
          height: baseLineHeight,
          fontWeight: FontWeight.w500,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          color: accent,
          fontFamily: fontFamily,
          height: baseLineHeight,
          fontWeight: FontWeight.w500,
        ),
      ),
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      buttonColor: buttonPrimaryFillColor,
      buttonTheme: ButtonThemeData(
        buttonColor: buttonPrimaryFillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeBorder.buttonRadius),
        ),
        textTheme: ButtonTextTheme.primary,
      ),
    );
