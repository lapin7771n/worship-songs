import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';

class LanguageItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Function onPressed;

  const LanguageItem({
    Key key,
    this.title,
    this.isSelected = false,
    this.onPressed,
  }) : super(key: key);

  @override
  _LanguageItemState createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 51,
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.blue : Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            color: widget.isSelected ? AppColors.blue : AppColors.bluishGray,
            width: 2,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: widget.isSelected ? AppColors.white : AppColors.black,
                ),
          ),
        ),
      ),
    );
  }
}
