import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/services/size_config.dart';

class FiltersButton extends StatelessWidget {
  final List<String> _languagesToLoad;
  final Function(BuildContext) _showFilterBottomSheet;

  const FiltersButton(this._languagesToLoad, this._showFilterBottomSheet);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 6,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        color: _isAllLanguages() ? AppColors.bluishGray : AppColors.blue,
        onPressed: () => _showFilterBottomSheet(context),
        child: Text(
          _getText(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: _isAllLanguages() ? AppColors.blue : AppColors.white,
              ),
        ),
      ),
    );
  }

  bool _isAllLanguages() => _languagesToLoad.length == 3;

  String _getText(BuildContext context) => _isAllLanguages()
      ? Strings.of(context).filters
      : '${Strings.of(context).filters}: ${_languagesToLoad.join(', ')}';
}
