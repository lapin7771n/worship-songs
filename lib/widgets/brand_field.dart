import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/app_text_styles.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/services/size_config.dart';

class BrandField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String errorText;
  final TextStyle textStyle;
  final String pathToPrefixIcon;

  final double borderRadius;

  final bool dynamicLines;
  final int maxLines;
  final int defaultLinesCount;
  final int maxLength;

  final Function(String) onFieldSubmitted;
  final Function(String) onChanged;
  final Function(String) validator;

  const BrandField({
    this.controller,
    this.title,
    this.hintText,
    this.textInputType,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.textInputAction,
    this.validator,
    this.errorText,
    this.textStyle,
    this.maxLength,
    this.obscureText = false,
    this.maxLines = 1,
    this.dynamicLines = false,
    this.defaultLinesCount = 20,
    this.borderRadius = 8,
    this.pathToPrefixIcon,
  }) : assert(
          dynamicLines == false || maxLines == 1,
          "Dynamic lines property doesn't work with max lines property",
        );

  @override
  _BrandFieldState createState() => _BrandFieldState();
}

class _BrandFieldState extends State<BrandField> {
  bool _obscuringEnabled;

  @override
  void initState() {
    _obscuringEnabled = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: widget.controller.text.length),
    );

    Widget title;
    if (widget.title != null)
      title = Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline5,
        ),
      );

    var inputDecoration = InputDecoration(
      errorText: widget.errorText,
      hintText: widget.hintText,
      contentPadding: EdgeInsets.symmetric(
        vertical: SizeConfig.safeBlockVertical * 2,
        horizontal: 16,
      ),
      hintStyle: AppTextStyles.inputContent.copyWith(
        color: AppColors.gray,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: Color(0xFF8DB1D9),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: AppColors.blue,
          width: 2,
        ),
      ),
      errorBorder: _buildErrorBorder(),
      focusedErrorBorder: _buildErrorBorder(),
      errorStyle: TextStyle(
        // fontSize: 12,
        fontSize: SizeConfig.blockSizeVertical * 1.5,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: widget.pathToPrefixIcon != null
          ? SvgPicture.asset(widget.pathToPrefixIcon)
          : null,
      suffixIcon: widget.obscureText
          ? GestureDetector(
              onTap: _toggleVisibility,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 1.5,
                  bottom: SizeConfig.safeBlockVertical * 1.5,
                  right: SizeConfig.safeBlockVertical,
                ),
                child: SvgPicture.asset(
                  _obscuringEnabled
                      ? ImagePathsHolder.EYE_CLOSED
                      : ImagePathsHolder.EYE_OPENED,
                  color: _obscuringEnabled ? AppColors.gray : AppColors.blue,
                ),
              ),
            )
          : null,
    );

    var textFormField = TextFormField(
      minLines: widget.dynamicLines ? widget.defaultLinesCount : 1,
      maxLines: widget.dynamicLines ? null : widget.maxLines,
      controller: widget.controller,
      maxLength: widget.maxLength,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      obscureText: _obscuringEnabled,
      autocorrect: false,
      keyboardType: widget.textInputType,
      style: widget.textStyle ?? AppTextStyles.inputContent,
      decoration: inputDecoration,
      onChanged: widget.onChanged,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) title,
        SizedBox(
          height: 8,
        ),
        textFormField
      ],
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: AppColors.red,
        width: 1,
      ),
    );
  }

  _toggleVisibility() {
    setState(() {
      _obscuringEnabled = !_obscuringEnabled;
    });
  }
}
