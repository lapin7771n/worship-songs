import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/screens/main_screen.dart';
import 'package:worshipsongs/services/auth_service.dart';
import 'package:worshipsongs/widgets/button.dart';

import 'auth_field.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;

  const AuthForm({
    this.isLogin = false,
  });

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FocusNode _emailFocusNode;
  FocusNode _passwordFocusNode;
  bool isEmailValid = false;
  bool isPasswordValid = true;
  String emailErrorText;
  String passwordErrorText;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _emailFocusNode.addListener(_emailFocusCallback);
    _passwordFocusNode.addListener(_passwordFocusCallback);

    _emailController.addListener(_emailFocusCallback);
    _passwordController.addListener(_passwordFocusCallback);
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var emailField = AuthField(
      title: 'Email Address',
      hintText: 'dolores.chambers@example.com',
      textInputType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (val) {
        _goToPassword(context);
      },
      controller: _emailController,
      errorText: emailErrorText,
    );

    var passwordField = AuthField(
      title: 'Create Password',
      hintText: '******',
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      errorText: passwordErrorText,
    );

    var passwordBottomText = Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 6.0),
      child: Text(
        'Password has to include at least 6 characters',
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: AppColors.gray),
      ),
    );

    var actionButton = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            child: Button(
              title: widget.isLogin ? 'Login' : 'Create new Account',
              onPressed: isEmailValid && isPasswordValid ? _handleAuth : null,
            ),
          ),
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                emailField,
                const SizedBox(
                  height: 32,
                ),
                passwordField,
                if (isPasswordValid) passwordBottomText,
              ],
            ),
          ),
          actionButton,
        ],
      ),
    );
  }

  void _goToPassword(BuildContext context) =>
      FocusScope.of(context).requestFocus(_passwordFocusNode);

  _validateEmail(String email) {
    if (email.isEmpty) {
      return;
    }
    Pattern emailPattern =
        (r"^((([!#$%&'*+\-/=?^_`{|}~\w])|([!#$%&'*+\-/=?^_`{|}~\w][!#$%&'*+\-/=?^_`{|}~\.\w]{0,}[!#$%&'*+\-/=?^_`{|}~\w]))[@]\w+([-.]\w+)*\.\w+([-.]\w+)*)$");
    var regExp = RegExp(emailPattern);
    isEmailValid = regExp.hasMatch(email);
    emailErrorText =
        isEmailValid ? null : 'This doesn’t looks like email address';
  }

  _validatePassword(String password) {
    if (password.isEmpty) {
      return;
    }
    isPasswordValid = password.length >= 6;
    passwordErrorText = isPasswordValid
        ? null
        : 'Your password contain ${password.length}/6 characters';
  }

  _emailFocusCallback() {
    setState(() {
      _validateEmail(_emailController.text);
    });
  }

  _passwordFocusCallback() {
    setState(() {
      _validatePassword(_passwordController.text);
    });
  }

  _handleAuth() async {
    FirebaseUser user;
    if (widget.isLogin) {
      user = await AuthService()
          .signIn(_emailController.text, _passwordController.text);
    } else {
      user = await AuthService()
          .createUser(_emailController.text, _passwordController.text);
    }

    if (user != null) {
      Navigator.of(context).pushNamed(MainScreen.routeName);
    }
  }
}