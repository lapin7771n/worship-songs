import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';

class FiltersButton extends StatelessWidget {
  final List<String> _languagesToLoad;
  final Function(BuildContext) _showFilterBottomSheet;

  const FiltersButton(this._languagesToLoad, this._showFilterBottomSheet);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 0,
      height: 0,
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: _isAllLanguages() ? AppColors.bluishGray : AppColors.blue,
        onPressed: () => _showFilterBottomSheet(context),
        child: Text(
          _getText(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.inputContent.copyWith(
            color: _isAllLanguages() ? AppColors.blue : AppColors.white,
          ),
        ),
      ),
    );
  }

  bool _isAllLanguages() =>
      _languagesToLoad.length == SongsProvider.supportedLanguages.length;

  String _getText(BuildContext context) => _isAllLanguages()
      ? Strings.of(context).filters
      : '${Strings.of(context).filters}: ${_languagesToLoad.join(', ')}';
}
