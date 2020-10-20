import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class AppTextStyles {
  static TextStyle get title1 {
    return _baseTextStyle.copyWith(
      fontSize: 32,
      height: 1.33,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get title2 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get title3 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get lyricsMiddle {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      height: 1.33
    );
  }

  static TextStyle get titleSongPlaylist {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get titleNavigation {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle get bodyTextRegular {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle get bodyTextCaption {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle get guitarChordsRegular {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get buttonLink {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle get inputContent {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle get guitarChordsSmall {
    return _baseTextStyle.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get _baseTextStyle {
    return TextStyle(
      fontFamily: 'Rubik',
      color: AppColors.black,
    );
  }

  AppTextStyles._();
}
