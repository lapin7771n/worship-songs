import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worshipsongs/data/auth_status.dart';

class AuthProvider with ChangeNotifier {
  static const String _USERS = 'users';

  static const String _DISPLAY_NAME = 'displayName';
  static const String _EMAIL = 'email';
  static const String _PHOTO_URL = 'photoUrl';
  static const String _CREATION_TIME = 'creationTime';
  static const String _LAST_SIGN_IN_TIME = 'lastSignInTime';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthStatus authStatus = AuthStatus.UNINITIALIZED;

  FirebaseUser _user;

  FirebaseUser get user => _user;

  Future<FirebaseUser> createUser(String email, String password) async {
    final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    _updateUser(authResult.user);
    return authResult.user;
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    final AuthResult authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _updateUser(authResult.user);
    return authResult.user;
  }

  Future signInViaGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

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
    _updateUser(user);
    print("Auto logged user: ${user?.email}");
    return user;
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
    authStatus = AuthStatus.UNAUTHENTICATED;
    _user = null;
    notifyListeners();
  }

  Future _updateUserInDatabase(FirebaseUser user) async {
    return await Firestore.instance
        .collection(_USERS)
        .document(user.uid)
        .updateData(_firebaseUserToJson(user));
  }

  Future _createUserInDatabase(FirebaseUser user) async {
    return await Firestore.instance
        .collection(_USERS)
        .document(user.uid)
        .setData(_firebaseUserToJson(user));
  }

  void _updateUser(FirebaseUser user) {
    authStatus =
        user == null ? AuthStatus.UNAUTHENTICATED : AuthStatus.AUTHENTICATED;
    _user = user;
    _updateUserInDatabase(user).catchError((error) {
      _createUserInDatabase(user);
    });
    notifyListeners();
  }

  Map<String, dynamic> _firebaseUserToJson(FirebaseUser user) {
    return {
      _DISPLAY_NAME: user.displayName,
      _EMAIL: user.email,
      _PHOTO_URL: user.photoUrl,
      _CREATION_TIME: user.metadata.creationTime,
      _LAST_SIGN_IN_TIME: user.metadata.lastSignInTime,
    };
  }
}
