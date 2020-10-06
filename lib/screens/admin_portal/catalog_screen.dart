import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/main_screen.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(Strings.of(context).catalog),
        actions: [
          Ink(
            decoration: ShapeDecoration(
              shape: CircleBorder(),
              color: Color(0xFFFAFAFA),
            ),
            child: IconButton(
              icon: SvgPicture.asset('assets/images/Logo.svg'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  MainScreen.routeName,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
