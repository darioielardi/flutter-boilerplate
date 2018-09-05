import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email'], signInOption: SignInOption.standard);
  final fire = Firestore.instance;
  final usersRef = Firestore.instance.collection('users');

  Stream<FirebaseUser> get state => _auth.onAuthStateChanged;

  Future handleGoogleSignin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw 'Authentication aborted';
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    return _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  Future<bool> _checkUserExists(FirebaseUser user) async {
    var userDoc = await usersRef.document(user.uid).get();
    return userDoc.exists;
  }

  Future<void> _createUser(FirebaseUser user) => usersRef.document(user.uid).setData({
        'username': user.displayName,
        'email': user.email,
        'imageUrl': user.photoUrl,
      });

  Future<DocumentReference> handleUserLoggedIn(FirebaseUser user) {
    return _checkUserExists(user).then((exists) async {
      if (!exists) await _createUser(user);
      return usersRef.document(user.uid);
    });
  }

  void handleSignOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }
}
