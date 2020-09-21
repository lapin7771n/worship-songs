import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/language_item.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/buttons.dart';

class FilterBottomSheet extends StatefulWidget {
  static const String EN = 'en';
  static const String RU = 'ru';
  static const String UA = 'ua';
  static const List<String> _ALL = [
    FilterBottomSheet.EN,
    FilterBottomSheet.RU,
    FilterBottomSheet.UA,
  ];

  static List<String> allLangs() => [..._ALL];

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
        ...Provider.of<SongsProvider>(
          context,
          listen: false,
        ).languagesToLoad
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
            onPressed: () {
              setState(() {
                chosenLanguages = FilterBottomSheet.allLangs();
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
        Strings.of(context).songLanguage,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget _buildLanguages() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockVertical,
          vertical: SizeConfig.safeBlockVertical),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageItem(
                isSelected: _isAllLangsSelected(),
                title: Strings.of(context).all,
                onPressed: _toggleAllLangs,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageItem(
                isSelected: chosenLanguages.contains(FilterBottomSheet.EN) &&
                    chosenLanguages.length != 3,
                title: Strings.of(context).english,
                onPressed: () => _toggleLanguage(FilterBottomSheet.EN),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageItem(
                isSelected: chosenLanguages.contains(FilterBottomSheet.RU) &&
                    chosenLanguages.length != 3,
                title: Strings.of(context).russian,
                onPressed: () => _toggleLanguage(FilterBottomSheet.RU),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LanguageItem(
                isSelected: chosenLanguages.contains(FilterBottomSheet.UA) &&
                    chosenLanguages.length != 3,
                title: Strings.of(context).ukrainian,
                onPressed: () => _toggleLanguage(FilterBottomSheet.UA),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildApplyButton(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 7,
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockVertical,
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
    return chosenLanguages.contains(FilterBottomSheet.EN) &&
        chosenLanguages.contains(FilterBottomSheet.RU) &&
        chosenLanguages.contains(FilterBottomSheet.UA);
  }

  void _toggleAllLangs() {
    setState(() {
      _isAllLangsSelected()
          ? chosenLanguages = []
          : chosenLanguages = FilterBottomSheet.allLangs();
    });
  }

  void _toggleLanguage(String langId) {
    setState(() {
      chosenLanguages.contains(langId)
          ? chosenLanguages.remove(langId)
          : chosenLanguages.add(langId);
    });
  }

  void _applyHandler() {
    Provider.of<SongsProvider>(
      context,
      listen: false,
    ).languagesToLoad = [...chosenLanguages];
    Navigator.of(context).pop();
  }
}
