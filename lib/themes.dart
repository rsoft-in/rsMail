import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

const FlexScheme usedScheme = FlexScheme.aquaBlue;

ThemeData theme() {
  return FlexThemeData.light(
    scheme: FlexScheme.redWine,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 20,
    appBarOpacity: 0.95,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
      bottomSheetRadius: 4.0,
      textButtonRadius: 4.0,
      elevatedButtonRadius: 4.0,
      outlinedButtonRadius: 4.0,
      toggleButtonsRadius: 4.0,
      inputDecoratorIsFilled: false,
      inputDecoratorRadius: 7.0,
      inputDecoratorUnfocusedBorderIsColored: false,
      fabRadius: 4.0,
      chipRadius: 4.0,
      cardRadius: 4.0,
      popupMenuRadius: 4.0,
      dialogRadius: 4.0,
      timePickerDialogRadius: 4.0,
      bottomNavigationBarOpacity: 0.60,
      navigationBarIndicatorOpacity: 0.15,
      navigationBarOpacity: 0.60,
      navigationRailLabelType: NavigationRailLabelType.selected,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}

ThemeData themeDark() {
  return FlexThemeData.dark(
    scheme: FlexScheme.redWine,
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 6,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.60,
    tabBarStyle: FlexTabBarStyle.forBackground,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      bottomSheetRadius: 4.0,
      textButtonRadius: 4.0,
      elevatedButtonRadius: 4.0,
      outlinedButtonRadius: 4.0,
      toggleButtonsRadius: 4.0,
      inputDecoratorIsFilled: false,
      inputDecoratorRadius: 7.0,
      inputDecoratorUnfocusedBorderIsColored: false,
      fabRadius: 4.0,
      chipRadius: 4.0,
      cardRadius: 4.0,
      popupMenuRadius: 4.0,
      dialogBackgroundSchemeColor: SchemeColor.shadow,
      dialogRadius: 4.0,
      timePickerDialogRadius: 4.0,
      bottomNavigationBarOpacity: 0.60,
      navigationBarIndicatorOpacity: 0.15,
      navigationBarOpacity: 0.60,
      navigationRailLabelType: NavigationRailLabelType.selected,
    ),
    keyColors: const FlexKeyColors(),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(width: 0.5, color: kBorderColor),
  );
  OutlineInputBorder focusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(width: 0.5, color: kPrimaryColor),
  );
  return InputDecorationTheme(
    // contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
    enabledBorder: outlineInputBorder,
    focusedBorder: focusedInputBorder,
    border: outlineInputBorder,
    filled: true,
  );
}
