import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/songs_provider.dart';
import 'package:worshipsongs/screens/home_screen/filters_button.dart';
import 'package:worshipsongs/services/size_config.dart';

import '../../app_colors.dart';
import 'filter_bottom_sheet.dart';

class HomeAppBar extends StatelessWidget {
  static const String _searchIconPath = 'assets/images/Search.svg';

  final FocusNode _searchFocus;
  final TextEditingController _controller;
  final bool _isSearchFocused;
  final Function _updateFiltersCallback;

  const HomeAppBar({
    FocusNode searchFocusNode,
    TextEditingController controller,
    bool isSearchFocused,
    Function updateFiltersCallback,
  })  : _searchFocus = searchFocusNode,
        _controller = controller,
        _isSearchFocused = isSearchFocused,
        _updateFiltersCallback = updateFiltersCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        top: SizeConfig.safeBlockVertical * 7,
        bottom: SizeConfig.safeBlockVertical,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.safeBlockVertical * 6,
            width: SizeConfig.safeBlockVertical * 100,
            child: Row(
              children: [
                _buildSearchField(context),
                if (_isSearchFocused)
                  FlatButton(
                    child: Text(Strings.of(context).cancel),
                    onPressed: () {
                      _controller.text = '';
                      _searchFocus.unfocus();
                    },
                  ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical,
          ),
          _buildFilters(context),
        ],
      ),
    );
  }

  Flexible _buildSearchField(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.1),
              spreadRadius: 4,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: TextField(
          focusNode: _searchFocus,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            enabledBorder: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockVertical * 1.3,
                vertical: SizeConfig.safeBlockVertical * 1.4,
              ),
              child: SvgPicture.asset(
                _searchIconPath,
                color: AppColors.black,
              ),
            ),
            hintText: Strings.of(context).typeSongName,
          ),
        ),
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
      child: FiltersButton(languagesToLoad, _showFilterBottomSheet),
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
