import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/buttons.dart';
import 'package:worshipsongs/widgets/languages_row.dart';

class FilterBottomSheet extends StatefulWidget {
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  List<String> chosenLanguages = [];

  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      chosenLanguages = [
        ...Provider.of<SongsProvider>(context, listen: false).languagesToLoad
      ];
      isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopRow(context),
          _buildTitle(context),
          _buildLanguages(),
          _buildApplyButton(context),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width * .3,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: Navigator.of(context).pop,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            Strings.of(context).filters,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width * .3,
          child: FlatButton(
            textColor: AppColors.blue,
            onPressed: _isAllLangsSelected()
                ? null
                : () {
                    setState(() {
                      chosenLanguages = [...SongsProvider.supportedLanguages];
                      _applyHandler();
                    });
                  },
            child: Text(
              Strings.of(context).reset,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.safeBlockVertical * 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        Strings.of(context).language,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget _buildLanguages() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: SizeConfig.safeBlockVertical,
      ),
      child: LanguagesRow(
        initialLanguages: [...chosenLanguages],
        languagesSelectedCallback: (languages) =>
            setState(() => chosenLanguages = languages),
      ),
    );
  }

  Container _buildApplyButton(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 7,
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: SizeConfig.safeBlockVertical * 3,
      ),
      width: MediaQuery.of(context).size.width,
      child: Button(
        onPressed: chosenLanguages.isEmpty ? null : _applyHandler,
        title: Strings.of(context).apply,
      ),
    );
  }

  bool _isAllLangsSelected() {
    return SongsProvider.supportedLanguages
        .every((element) => chosenLanguages.contains(element));
  }

  void _applyHandler() {
    Provider.of<SongsProvider>(
      context,
      listen: false,
    ).languagesToLoad = [...chosenLanguages];
    Navigator.of(context).pop();
  }
}
