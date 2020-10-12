import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';

class Benefit extends StatelessWidget {
  final String benefitIconPath;
  final String title;
  final String description;

  const Benefit({
    Key key,
    @required this.benefitIconPath,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            benefitIconPath,
            color: AppColors.blue,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  description,
                  style: AppTextStyles.bodyTextRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
