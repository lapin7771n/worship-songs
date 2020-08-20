import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String errorText;

  final Function(String) onFieldSubmitted;
  final Function(String) validator;

  const BrandField({
    this.title,
    this.hintText,
    this.textInputType,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.controller,
    this.errorText,
  });

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
    Widget title;
    if (widget.title != null)
      title = Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline4,
        ),
      );

    var inputDecoration = InputDecoration(
        errorText: widget.errorText,
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: _toggleVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    right: 16,
                  ),
                  child: SvgPicture.asset('assets/images/Closed.svg'),
                ),
              )
            : null);

    var textFormField = TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      obscureText: _obscuringEnabled,
      autocorrect: false,
      keyboardType: widget.textInputType,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: inputDecoration,
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

  _toggleVisibility() {
    setState(() {
      _obscuringEnabled = !_obscuringEnabled;
    });
  }
}
