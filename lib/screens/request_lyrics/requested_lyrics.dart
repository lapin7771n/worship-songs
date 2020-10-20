import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_text/styled_text.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/bloc/request_lyrics_bloc/request_lyrics_bloc.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/repositories/request_lyrics_repository.dart';
import 'package:worshipsongs/screens/request_lyrics/widgets/request_bottom_controls.dart';

class RequestLyrics extends StatelessWidget {
  static const String routeName = '/request-lyrics';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestLyricsBloc(RequestLyricsRepository()),
      child: BlocBuilder<RequestLyricsBloc, RequestLyricsState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: CloseButton(),
            title: Text(
              Strings.of(context).requestLyrics,
              style: AppTextStyles.title3,
            ),
            bottom: PreferredSize(
              child: progressInformation(context, state),
              preferredSize: Size.fromHeight(80),
            ),
          ),
          body: body(context, state),
        ),
      ),
    );
  }

  Widget body(BuildContext context, RequestLyricsState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          state.getPage(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: RequestBottomControls(
              nextButtonText: state.getButtonText(context),
              onNextClicked: state is CompletedStep
                  ? () => nextButtonClickHandler(context)
                  : null,
              onBackClicked: isFirstStep(state)
                  ? null
                  : () => backButtonClickHandler(context),
            ),
          ),
        ],
      ),
    );
  }

  bool isFirstStep(RequestLyricsState state) => state.progress * 10 ~/ 3 == 1;

  nextButtonClickHandler(BuildContext context) {
    BlocProvider.of<RequestLyricsBloc>(context).add(
      RequestLyricsNextStepClicked(),
    );
  }

  backButtonClickHandler(BuildContext context) {
    BlocProvider.of<RequestLyricsBloc>(context).add(
      RequestLyricsBackClicked(),
    );
  }

  Widget progressInformation(BuildContext context, RequestLyricsState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          progressIndicator(state),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.getTitle(context),
                style: AppTextStyles.titleSongPlaylist,
              ),
              Text(
                state.getDescription(context),
                style: AppTextStyles.bodyTextCaption,
              ),
            ],
          )
        ],
      ),
    );
  }

  Stack progressIndicator(RequestLyricsState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(
            value: state.progress,
            backgroundColor: AppColors.bluishGray,
          ),
        ),
        StyledText(
          text:
              '<current>${state.progress * 10 ~/ 3}</current><steps>/3</steps>',
          styles: {
            'steps': AppTextStyles.guitarChordsSmall.copyWith(
              color: AppColors.gray,
            ),
            'current': AppTextStyles.title3.copyWith(
              color: AppColors.blue,
            ),
          },
        )
      ],
    );
  }
}
