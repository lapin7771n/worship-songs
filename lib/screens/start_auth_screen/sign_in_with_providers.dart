import 'dart:convert';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/data/image_paths_holder.dart';
import 'package:worshipsongs/data/wsongs_user.dart';
import 'package:worshipsongs/localizations/strings.dart';
import 'package:worshipsongs/providers/auth_provider.dart';
import 'package:worshipsongs/screens/main_screen.dart';
import 'package:worshipsongs/screens/start_auth_screen/benefit.dart';
import 'package:worshipsongs/screens/start_auth_screen/sign_in_provider_button.dart';

class SignInWithProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.blue,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context).easierWayToLogin,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 32,
          ),
          Benefit(
            benefitIconPath: ImagePathsHolder.ZAP,
            title: Strings.of(context).weRespectYourTime,
            description: Strings.of(context).usingSocialMediaLoginYouWill,
          ),
          SizedBox(
            height: 24,
          ),
          Benefit(
            benefitIconPath: ImagePathsHolder.SHIELD,
            title: Strings.of(context).itsReallySave,
            description: Strings.of(context).noMorePasswordsToForgot,
          ),
          SizedBox(
            height: 32,
          ),
          FutureBuilder(
            future: AppleSignIn.isAvailable(),
            builder: (ctx, value) => value.hasData && value.data
                ? SignInProviderButton(
                    providerType: ProviderType.apple,
                    onPressed: () => signInWithApple(context),
                  )
                : Container(),
          ),
          SizedBox(
            height: 24,
          ),
          SignInProviderButton(
            providerType: ProviderType.google,
            onPressed: () => signInWithGoogle(context),
          ),
        ],
      ),
    );
  }

  Future signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = auth.currentUser;
    authUser(authResult.additionalUserInfo.isNewUser, context, currentUser);
  }

  void signInWithApple(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    final appleIdCredential = result.credential;
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: String.fromCharCodes(appleIdCredential.identityToken),
      accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
    );
    final authResult = await auth.signInWithCredential(credential);
    final firebaseUser = authResult.user;
    authUser(authResult.additionalUserInfo.isNewUser, context, firebaseUser);
  }

  void authUser(bool isNewUser, BuildContext context, User user) async {
    var key = utf8.encode(
      "@d&#?wfCErPV?=YaFbw&L9UYA#WEHG@v-5!MhF8djY9FBjZhyY7bTm5%mf#qwvDV",
    );
    var hmac = Hmac(sha256, key);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    final password = base64Encode(hmac.convert(utf8.encode(user.uid)).bytes);
    WSongsUser wSongsUser;
    if (isNewUser) {
      wSongsUser = await authProvider.createUser(user.email, password);
    } else {
      wSongsUser = await authProvider.signIn(user.email, password);
    }

    if (wSongsUser != null) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    }
  }
}
