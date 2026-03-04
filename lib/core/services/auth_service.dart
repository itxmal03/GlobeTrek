import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    final userCreds = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final userId = userCreds.user!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      "userName": userName,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await userCreds.user!.sendEmailVerification();
    await _auth.signOut();
    return userCreds;
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final userCred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!userCred.user!.emailVerified) {
      await _auth.signOut();
      throw FirebaseAuthException(
        code: "email-not-verified",
        message: "Please verify your email before logging in.",
      );
    }

    return userCred;
  }
}
