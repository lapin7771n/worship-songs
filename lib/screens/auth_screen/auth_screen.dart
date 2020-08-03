import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/auth_screen/widgets/auth_form.dart';
import 'package:worshipsongs/services/auth_service.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';
  static const int OPACITY_20 = 51;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text('Create new Account'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    _buildGoogleButton(context),
                    Divider(
                      thickness: 2,
                      color: AppColors.gray.withAlpha(OPACITY_20),
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: AuthForm(),
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
        onPressed: () {
          AuthService().signInViaGoogle();
        },
        icon: SvgPicture.asset('assets/images/GoogleIcon.svg'),
        label: Text(
          'Continue with Google',
          style: Theme.of(context).textTheme.headline3.apply(
                color: AppColors.blue,
              ),
        ),
      ),
    );
  }
}
