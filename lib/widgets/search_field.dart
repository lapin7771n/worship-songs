import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/services/size_config.dart';

class SearchField extends StatefulWidget {
  static const String _SEARCH_ICON_PATH = 'assets/images/Search.svg';
  static const double _SHADOW_OPACITY = 0.1;
  static const double _SHADOW_SPREAD_RADIUS = 3;
  static const double _SHADOW_Y_OFFSET = 1;
  static const double _SHADOW_BLUR_RADIUS = 10;

  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;

  SearchField({
    @required this.controller,
    @required this.hintText,
    @required this.focusNode,
  });

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    widget.focusNode.addListener(focusCallback);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(focusCallback);
    super.dispose();
  }

  focusCallback() {
    setState(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 8,
      width: SizeConfig.safeBlockHorizontal * 100,
      child: Row(
        children: [
          buildSearch(context),
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            constraints: BoxConstraints(
              minWidth: 0,
              maxWidth: widget.focusNode.hasFocus
                  ? SizeConfig.safeBlockHorizontal * 22
                  : 0,
            ),
            child: TextButton(
              child: Text(
                Strings.of(context).cancel,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: AppColors.black,
                    ),
              ),
              onPressed: () {
                setState(() {
                  widget.controller.text = '';
                  widget.focusNode.unfocus();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(SearchField._SHADOW_OPACITY),
              spreadRadius: SearchField._SHADOW_SPREAD_RADIUS,
              offset: Offset(0, SearchField._SHADOW_Y_OFFSET),
              blurRadius: SearchField._SHADOW_BLUR_RADIUS,
            ),
          ],
        ),
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockVertical * 1.8,
                vertical: SizeConfig.safeBlockVertical * 1.6,
              ),
              child: SvgPicture.asset(
                SearchField._SEARCH_ICON_PATH,
                color: widget.focusNode.hasFocus
                    ? AppColors.blue
                    : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
