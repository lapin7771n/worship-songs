import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
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
        title: Text(isLogin
            ? Strings.of(context).login
            : Strings.of(context).createNewAccount),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    // _buildGoogleButton(context),
                    Divider(
                      thickness: 2,
                      color: AppColors.gray.withAlpha(OPACITY_20),
                    ),
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

  Widget _buildGoogleButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 25),
      child: RaisedButton.icon(
        highlightElevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.white,
        onPressed: () => _handleGoogleAuth(context),
        icon: SvgPicture.asset('assets/images/GoogleIcon.svg'),
        label: Text(
          Strings.of(context).continueWithGoogle,
          style: Theme.of(context).textTheme.headline3.apply(
                color: AppColors.blue,
              ),
        ),
      ),
    );
  }

  _handleGoogleAuth(BuildContext context) async {
    final firebaseUser = await Provider.of<AuthProvider>(context, listen: false)
        .signInViaGoogle();
    if (firebaseUser != null) {
      Navigator.of(context).pop();
    }
  }
}
