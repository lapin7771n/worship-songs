import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class AppTextStyles {
  static TextStyle get title3 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get bodyTextRegular {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,
    );
  }

  static TextStyle get buttonLink {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle get titleSongPlaylist {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle get _baseTextStyle {
    return TextStyle(
      fontFamily: 'Rubik',
      color: AppColors.black,
    );
  }
}
