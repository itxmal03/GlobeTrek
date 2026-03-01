import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:globe_trek/core/services/auth_service.dart';
import 'package:globe_trek/core/utils/result.dart';

class AuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  Future<Result> signUp({
    required String uName,
    required String uEmail,
    required String uPassword,
  }) async {
    try {
      final user = await _service.signUp(
        userName: uName,
        email: uEmail,
        password: uPassword,
      );
      return Result.success(user);
    } on FirebaseAuthException catch (e) {
      return Result.failure(_mapFirebaseError(e));
    } on TimeoutException {
      return Result.failure("Request timed out. Please try again.");
    } on SocketException {
      return Result.failure("No internet connection.");
    } catch (e) {
      return Result.failure("Something went wrong.");
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "This email is already registered.";
      case 'weak-password':
        return "Password is too weak.";
      case 'network-request-failed':
        return "Check your internet connection.";
      default:
        return e.message ?? "Authentication failed.";
    }
  }
}
