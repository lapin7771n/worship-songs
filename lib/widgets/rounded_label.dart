import 'package:flutter/material.dart';

class RoundedLabel extends StatelessWidget {
  final String title;

  const RoundedLabel({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFC8D7E5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
