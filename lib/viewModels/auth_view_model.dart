import 'package:flutter/foundation.dart';
import 'package:globe_trek/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;
  AuthViewModel(this._repo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? errorMessage;

  Future<bool> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repo.signUp(
      uName: userName,
      uEmail: email,
      uPassword: password,
    );

    if (result.isFailure) {
      errorMessage = result.error;
      notifyListeners();
      return false;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
