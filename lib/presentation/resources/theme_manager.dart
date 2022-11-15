import 'package:caesar_cipher/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import 'colors_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // mainColors
    primarySwatch: ColorManager.primarySwatch,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryLight,
    fontFamily: FontConstants.fontFamily,

    // cardTheme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      elevation: AppSize.s4,
      shadowColor: ColorManager.grey,
    ),

    // app bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      shadowColor: ColorManager.primaryLight,
      elevation: AppSize.s4,
      titleTextStyle: getBoldTextStyle(
        color: ColorManager.white,
        fontSize: FontSizeManager.s22,
      ),
    ),

    // buttons Theme
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      highlightColor: ColorManager.primaryLight,
      splashColor: ColorManager.primaryLight,
      shape: StadiumBorder(),
    ),

    //elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(
          color: ColorManager.white,
          fontSize: FontSizeManager.s17,
        ),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // textTheme

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      // hint text style
      hintStyle: getRegularTextStyle(
        color: ColorManager.grey,
        fontSize: FontSizeManager.s14,
      ),

      // label text style
      labelStyle: getMediumTextStyle(
        color: ColorManager.grey,
        fontSize: FontSizeManager.s14,
      ),

      //error text style
      errorStyle: getRegularTextStyle(
        color: ColorManager.error,
        fontSize: FontSizeManager.s14,
      ),

      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //disabled border style
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.grey1,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
