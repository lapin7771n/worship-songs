import 'package:flutter/material.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/screens/auth_screen/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';
  static const int OPACITY_20 = 51;

  @override
  Widget build(BuildContext context) {
    final bool isLogin = ModalRoute.of(context).settings.arguments as bool;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          isLogin
              ? Strings.of(context).login
              : Strings.of(context).createNewAccount,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 32),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: AuthForm(
                  isLogin: isLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
