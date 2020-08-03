import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<FirebaseUser> createUser(String email, String password) async {
    var auth = FirebaseAuth.instance;
    return (await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    var auth = FirebaseAuth.instance;
    return (await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  Future<FirebaseUser> signInViaGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    return (await auth.signInWithCredential(credential)).user;
  }
}
