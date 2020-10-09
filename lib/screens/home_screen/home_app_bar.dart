import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/filters_button.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/search_field.dart';

import 'filter_bottom_sheet.dart';

class HomeAppBar extends StatelessWidget {
  final FocusNode _searchFocus;
  final TextEditingController _controller;
  final Function _updateFiltersCallback;

  const HomeAppBar({
    FocusNode searchFocusNode,
    TextEditingController controller,
    bool isSearchFocused,
    Function updateFiltersCallback,
  })  : _searchFocus = searchFocusNode,
        _controller = controller,
        _updateFiltersCallback = updateFiltersCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + SizeConfig.safeBlockVertical,
        bottom: SizeConfig.safeBlockVertical,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchField(
            controller: _controller,
            focusNode: _searchFocus,
            hintText: Strings.of(context).typeSongName,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          _buildFilters(context),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final languagesToLoad = Provider.of<SongsProvider>(
      context,
      listen: false,
    ).languagesToLoad.map((e) => _getLanguageFromCode(e, context)).toList();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FiltersButton(languagesToLoad, _showFilterBottomSheet),
      ),
    );
  }

  String _getLanguageFromCode(String languageId, BuildContext context) {
    switch (languageId) {
      case 'en':
        return Strings.of(context).english;
      case 'ru':
        return Strings.of(context).russian;
      case 'ua':
        return Strings.of(context).ukrainian;
    }
    return '';
  }

  void _showFilterBottomSheet(BuildContext context) async {
    await showCupertinoModalBottomSheet(
        context: context,
        bounce: true,
        expand: false,
        barrierColor: Colors.black45,
        builder: (ctx, scrollController) => FilterBottomSheet());

    _updateFiltersCallback();
  }
}
