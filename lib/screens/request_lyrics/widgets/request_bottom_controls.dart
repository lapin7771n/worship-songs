import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/widgets/buttons.dart';

class RequestBottomControls extends StatelessWidget {
  final String nextButtonText;

  final Function onBackClicked;
  final Function onNextClicked;

  const RequestBottomControls({
    Key key,
    @required this.nextButtonText,
    this.onBackClicked,
    this.onNextClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
          left: 16,
          right: 16,
        ),
        color: Colors.white,
        height: 88 + MediaQuery.of(context).padding.bottom,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 2,
                  color: AppColors.bluishGray,
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left_rounded,
                  size: 32,
                ),
                onPressed: onBackClicked,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Button(
                title: nextButtonText,
                onPressed: onNextClicked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
