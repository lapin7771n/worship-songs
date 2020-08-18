import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worshipsongs/data/auth_status.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus authStatus = AuthStatus.UNINITIALIZED;

  FirebaseUser _user;

  FirebaseUser get user => _user;

  Future createUser(String email, String password) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _updateUser(authResult.user);
  }

  Future signIn(String email, String password) async {
    final AuthResult authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _updateUser(authResult.user);
  }

  Future signInViaGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    AuthResult authResult = await auth.signInWithCredential(credential);
    _updateUser(authResult.user);
  }

  Future tryToLogin() async {
    print("Trying to auto login");
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) _updateUser(user);
    print("Auto logged user: ${user?.email}");
    return user;
  }

  void _updateUser(FirebaseUser user) {
    authStatus =
        user == null ? AuthStatus.UNAUTHENTICATED : AuthStatus.AUTHENTICATED;
    _user = user;
    notifyListeners();
  }
}
