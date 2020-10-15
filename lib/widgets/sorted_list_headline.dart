import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';

class SortedListHeadline extends StatelessWidget {
  final String text;

  const SortedListHeadline({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.blue, boxShadow: [
            BoxShadow(
              color: AppColors.blue.withOpacity(0.2),
              blurRadius: 16,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: AppTextStyles.title2.copyWith(color: AppColors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
