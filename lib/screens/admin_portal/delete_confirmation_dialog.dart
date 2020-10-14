import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/content_type.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/widgets/buttons.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final ContentType contentType;

  const DeleteConfirmationDialog({
    Key key,
    @required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        contentType.deleteTitle(context),
        textAlign: TextAlign.center,
      ),
      titleTextStyle: AppTextStyles.title2,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            contentType.deleteDescription(context),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyTextRegular,
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: Button(
              title: contentType.deleteTitle(context),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 56,
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                Strings.of(context).cancel,
                style: AppTextStyles.buttonLink.copyWith(
                  color: AppColors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
