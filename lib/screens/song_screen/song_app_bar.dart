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
  static const Duration ANIMATION_DURATION = const Duration(milliseconds: 300);

  static const double INITIAL_APP_BAR_HEIGHT = 30;
  static const double INITIAL_OPACITY = 1;
  static const double INITIAL_TITLE_TOP_PADDING = 12;
  static const double INITIAL_TITLE_HORIZONTAL_PADDING = 1;
  static const double INITIAL_ELEVATION = 0;
  static const double INITIAL_SAFE_PADDING = 5;

  static const double COLLAPSED_ELEVATION = 5;
  static const double COLLAPSED_APP_BAR_HEIGHT = 11;
  static const double COLLAPSED_OPACITY = 0;
  static const double COLLAPSED_TITLE_TOP_PADDING = 2.75;
  static const double COLLAPSED_TITLE_HORIZONTAL_PADDING = 6;
  static const double COLLAPSED_SAFE_PADDING = 3;

  double previewOpacity = INITIAL_OPACITY;
  double elevation = INITIAL_ELEVATION;
  double appBarSize = INITIAL_APP_BAR_HEIGHT;
  double titleTopPadding = INITIAL_TITLE_TOP_PADDING;
  double titleHorizontalPadding = INITIAL_TITLE_HORIZONTAL_PADDING;
  double safePadding = INITIAL_SAFE_PADDING;

  double prevScrollPosition = 0;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      widget._scrollController.addListener(_scrollListener);
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
    return Material(
      elevation: elevation,
      child: AnimatedContainer(
        duration: ANIMATION_DURATION,
        color: AppColors.white,
        height: SizeConfig.blockSizeVertical * appBarSize,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            top: SizeConfig.blockSizeVertical * safePadding,
            right: 16.0,
          ),
          child: Stack(
            children: [
              ..._buildTopBar(widget._song, context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTopBar(Song song, BuildContext context) {
    return [_buildActions(context, song), _buildInfo(song, context)];
  }

  void _scrollListener() {
    final ScrollController scrollController = widget._scrollController;
    final maxScroll = scrollController.position.maxScrollExtent;
    final double percents = scrollController.offset / maxScroll;
    final scrollPercents = _calculatePercents(percents);

    if (scrollPercents > 20) return;

    setState(() {
      prevScrollPosition > scrollPercents ? _expandAppBar() : _collapseAppBar();
    });

    prevScrollPosition = scrollPercents;
  }

  _expandAppBar() {
    previewOpacity = INITIAL_OPACITY;
    appBarSize = INITIAL_APP_BAR_HEIGHT;
    elevation = INITIAL_ELEVATION;
    titleTopPadding = INITIAL_TITLE_TOP_PADDING;
    safePadding = INITIAL_SAFE_PADDING;
    titleHorizontalPadding = INITIAL_TITLE_HORIZONTAL_PADDING;
  }

  _collapseAppBar() {
    previewOpacity = COLLAPSED_OPACITY;
    appBarSize = COLLAPSED_APP_BAR_HEIGHT;
    elevation = COLLAPSED_ELEVATION;
    titleTopPadding = COLLAPSED_TITLE_TOP_PADDING;
    safePadding = COLLAPSED_SAFE_PADDING;
    titleHorizontalPadding = COLLAPSED_TITLE_HORIZONTAL_PADDING;
  }

  double _calculatePercents(double percents) {
    if (percents < 0) {
      return 0;
    } else if (percents > 1) {
      return 100;
    } else {
      return percents * 100;
    }
  }

  Widget _buildActions(BuildContext context, Song song) {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CloseButton(
            onPressed: Navigator.of(context).pop,
          ),
          AnimatedOpacity(
            duration: ANIMATION_DURATION,
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
          SongFavoriteAction(song.uuid),
        ],
      ),
    );
  }

  Widget _buildInfo(Song song, BuildContext context) {
    return AnimatedContainer(
      duration: ANIMATION_DURATION,
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * titleTopPadding,
        left: SizeConfig.blockSizeVertical * titleHorizontalPadding,
        right: SizeConfig.blockSizeVertical * titleHorizontalPadding,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: ANIMATION_DURATION,
              textAlign: isCollapsed() ? TextAlign.left : TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: isCollapsed() ? 1 : 3,
              style: isCollapsed()
                  ? Theme.of(context).textTheme.headline3
                  : Theme.of(context).textTheme.headline2,
              child: Text(
                song.title,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if (previewOpacity > 0.2)
              AnimatedOpacity(
                duration: ANIMATION_DURATION,
                opacity: previewOpacity,
                child: Hero(
                  tag: song.uuid + song.author.hashCode,
                  child: Text(
                    song.author,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: AppColors.gray),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool isCollapsed() => elevation == COLLAPSED_ELEVATION;
}
