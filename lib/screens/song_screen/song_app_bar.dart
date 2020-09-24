import 'package:flutter/material.dart';
import 'package:worshipsongs/data/song.dart';
import 'package:worshipsongs/screens/song_screen/song_favorite_action.dart';
import 'package:worshipsongs/services/size_config.dart';
import 'package:worshipsongs/widgets/song_cover_image.dart';

import '../../app_colors.dart';

class SongAppBar extends StatefulWidget {
  const SongAppBar(this._song, this._scrollController);

  final Song _song;
  final ScrollController _scrollController;

  @override
  _SongAppBarState createState() => _SongAppBarState();
}

class _SongAppBarState extends State<SongAppBar> {
  static const Duration FAST_ANIMATION_DURATION =
      const Duration(milliseconds: 50);
  static const Duration SLOW_ANIMATION_DURATION =
      const Duration(milliseconds: 300);
  static const Curve CURVE = Curves.linear;

  static const double INITIAL_OPACITY = 1;
  static const double INITIAL_LARGE_TITLE_TOP_PADDING = 130;
  static const double INITIAL_ELEVATION = 0;
  static const double INITIAL_HORIZONTAL_PADDING = 16.0;
  static const double TITLE_HORIZONTAL_PADDING = 8;

  double safePadding;
  double previewOpacity = INITIAL_OPACITY;
  double elevation = INITIAL_ELEVATION;
  double largeTitleTopPadding = INITIAL_LARGE_TITLE_TOP_PADDING;
  double horizontalPadding = INITIAL_HORIZONTAL_PADDING;
  double smallHeaderOpacity = INITIAL_OPACITY - 1;

  double prevScrollPosition = 0;

  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      widget._scrollController.addListener(_scrollListener);
      safePadding = MediaQuery.of(context).padding.top;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: CURVE,
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      duration: FAST_ANIMATION_DURATION,
      color: AppColors.white,
      child: Stack(
        children: [
          ..._buildTopBar(widget._song, context),
        ],
      ),
    );
  }

  List<Widget> _buildTopBar(Song song, BuildContext context) {
    return [
      _buildActions(context, song),
      _buildInfo(context, song),
    ];
  }

  Widget _buildSmallHeader(BuildContext context, Song song) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeVertical * TITLE_HORIZONTAL_PADDING,
        right: SizeConfig.blockSizeVertical * TITLE_HORIZONTAL_PADDING,
      ),
      child: AnimatedOpacity(
        duration: FAST_ANIMATION_DURATION,
        opacity: smallHeaderOpacity,
        curve: CURVE,
        child: Text(
          song.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, Song song) {
    return AnimatedContainer(
      duration: FAST_ANIMATION_DURATION,
      curve: CURVE,
      padding: EdgeInsets.only(
        top: safePadding + largeTitleTopPadding,
        left: SizeConfig.blockSizeHorizontal * TITLE_HORIZONTAL_PADDING,
        right: SizeConfig.blockSizeHorizontal * TITLE_HORIZONTAL_PADDING,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(song, context),
            SizedBox(
              height: 8,
            ),
            _buildAuthor(song, context),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthor(Song song, BuildContext context) {
    return AnimatedContainer(
      duration: FAST_ANIMATION_DURATION,
      curve: CURVE,
      child: previewOpacity == 0
          ? null
          : AnimatedOpacity(
              duration: FAST_ANIMATION_DURATION,
              opacity: previewOpacity,
              child: Text(
                song.author,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: AppColors.gray,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget _buildTitle(Song song, BuildContext context) {
    return AnimatedContainer(
      duration: FAST_ANIMATION_DURATION,
      curve: CURVE,
      child: previewOpacity == 0
          ? null
          : AnimatedOpacity(
              duration: FAST_ANIMATION_DURATION,
              opacity: previewOpacity,
              curve: CURVE,
              child: Text(
                song.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
    );
  }

  Widget _buildActions(BuildContext context, Song song) {
    return Material(
      elevation: elevation,
      color: AppColors.white,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: safePadding,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CloseButton(
                  onPressed: Navigator.of(context).pop,
                ),
                AnimatedContainer(
                  curve: CURVE,
                  duration: SLOW_ANIMATION_DURATION,
                  height: previewOpacity == 0 ? 0 : 88,
                  width: previewOpacity == 0 ? 0 : 88,
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                  child: AnimatedOpacity(
                    curve: CURVE,
                    duration: FAST_ANIMATION_DURATION,
                    opacity: previewOpacity,
                    child: Hero(
                      tag: song.uuid,
                      child: SongCoverImage(
                        title: song.title,
                        author: song.author,
                        isBig: true,
                      ),
                    ),
                  ),
                ),
                SongFavoriteAction(song.uuid),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: safePadding,
            ),
            child: _buildSmallHeader(context, song),
          ),
        ],
      ),
    );
  }

  void _scrollListener() {
    final ScrollController scrollController = widget._scrollController;
    final double offset = scrollController.offset;
    final double computedOffset = scrollController.offset / 4;
    final double maxScrollRange = 20;
    print(scrollController.offset);

    if (computedOffset > maxScrollRange &&
        smallHeaderOpacity == INITIAL_OPACITY) {
      return;
    }

    if (computedOffset < maxScrollRange / 3) {
      setState(() {
        previewOpacity = INITIAL_OPACITY;
        elevation = INITIAL_ELEVATION;
        largeTitleTopPadding = INITIAL_LARGE_TITLE_TOP_PADDING;
        smallHeaderOpacity = 0;
      });
      return;
    }

    if (computedOffset >= maxScrollRange) {
      setState(() {
        previewOpacity = 0.0;
        elevation = 5;
        largeTitleTopPadding = INITIAL_LARGE_TITLE_TOP_PADDING / 5;
        smallHeaderOpacity = INITIAL_OPACITY;
        horizontalPadding = 8;
      });
      return;
    }

    setState(() {
      elevation = INITIAL_ELEVATION + computedOffset / 5;
      largeTitleTopPadding = INITIAL_LARGE_TITLE_TOP_PADDING - offset;
      horizontalPadding =
          INITIAL_HORIZONTAL_PADDING / (computedOffset * 2 / maxScrollRange);

      final _theoryPreviewOpacity =
          INITIAL_OPACITY - computedOffset / maxScrollRange;
      if (computedOffset < maxScrollRange / 1.5) {
        previewOpacity = _theoryPreviewOpacity / 1.5;
      } else {
        smallHeaderOpacity = 1 - _theoryPreviewOpacity * 3;
      }
    });
  }

  bool isCollapsed() => elevation > INITIAL_ELEVATION + 2;
}
