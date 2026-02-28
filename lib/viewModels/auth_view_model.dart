import 'package:flutter/foundation.dart';
import 'package:globe_trek/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo;
  AuthViewModel(this._repo);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? errorMessage;

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repo.signUp(email, password);

    if (result.isFailure) {
      errorMessage = result.error;
    }

    _isLoading = false;
    notifyListeners();
  }
}
