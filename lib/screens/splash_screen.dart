import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/providers/auth_provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).tryToLogin();
    return Scaffold(
      body: Center(
        child: Text(
          'Worship songs',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
