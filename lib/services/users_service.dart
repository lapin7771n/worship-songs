import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersService {
  static const String _USERS = 'users';

  static const String _DISPLAY_NAME = 'displayName';
  static const String _EMAIL = 'email';
  static const String _PHOTO_URL = 'photoUrl';
  static const String _CREATION_TIME = 'creationTime';
  static const String _LAST_SIGN_IN_TIME = 'lastSignInTime';

  static void createUser(FirebaseUser user) {
    Firestore.instance.collection(_USERS).document(user.uid).setData({
      _DISPLAY_NAME: user.displayName,
      _EMAIL: user.email,
      _PHOTO_URL: user.photoUrl,
      _CREATION_TIME: user.metadata.creationTime,
      _LAST_SIGN_IN_TIME: user.metadata.lastSignInTime,
    });
  }
}
