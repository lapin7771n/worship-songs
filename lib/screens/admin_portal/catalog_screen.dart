import 'package:flutter/material.dart';
import 'package:worshipsongs/localizations/strings.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).catalog),
      ),
    );
  }
}
