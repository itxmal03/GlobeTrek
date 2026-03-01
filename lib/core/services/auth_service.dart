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
      "createdAt": Timestamp.now(),
    });
    
    return userCreds;
  }
}
