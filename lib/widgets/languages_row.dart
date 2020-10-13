import 'package:flutter/material.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/language_item.dart';

class LanguagesRow extends StatefulWidget {
  final Function(List<String>) languagesSelectedCallback;
  final List<String> initialLanguages;
  final bool isWithAll;
  final bool isSingleLanguage;

  const LanguagesRow({
    Key key,
    @required this.languagesSelectedCallback,
    @required this.initialLanguages,
    this.isWithAll = true,
    this.isSingleLanguage = false,
  }) : super(key: key);

  @override
  _LanguagesRowState createState() => _LanguagesRowState();
}

class _LanguagesRowState extends State<LanguagesRow> {
  List<String> chosenLanguages = [];

  @override
  void initState() {
    chosenLanguages = widget.initialLanguages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (widget.isWithAll)
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
          ...SongsProvider.supportedLanguages
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LanguageItem(
                      isSelected: _isLanguageChecked(e),
                      title: Strings.of(context).getLanguageByCode(e),
                      onPressed: () => _toggleLanguage(e),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  bool _isAllLangsSelected() {
    return SongsProvider.supportedLanguages
        .every((element) => chosenLanguages.contains(element));
  }

  void _toggleAllLangs() {
    setState(() {
      _isAllLangsSelected()
          ? chosenLanguages = []
          : chosenLanguages = [...SongsProvider.supportedLanguages];
    });
  }

  void _toggleLanguage(String langId) {
    setState(() {
      if (widget.isSingleLanguage) {
        chosenLanguages = [langId];
        return;
      }

      if (_isAllLangsSelected()) {
        chosenLanguages.clear();
        chosenLanguages.add(langId);
        return;
      }

      chosenLanguages.contains(langId)
          ? chosenLanguages.remove(langId)
          : chosenLanguages.add(langId);
    });
    widget.languagesSelectedCallback(chosenLanguages);
  }

  bool _isLanguageChecked(String langId) {
    return chosenLanguages.contains(langId) &&
        chosenLanguages.length != SongsProvider.supportedLanguages.length;
  }
}
