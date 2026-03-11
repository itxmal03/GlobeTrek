import 'package:flutter/material.dart';
import 'package:globe_trek/repositories/popular_places_repository.dart';

class PopularPlacesViewModel extends ChangeNotifier {
  final PopularPlacesRepository _repo = PopularPlacesRepository();
  bool _isLoading = false;
  String? errorMessage;

  //getter for isLoading
  bool get isLoading => _isLoading;

  Future<bool> getPlaces() async {
    _isLoading = true;
    notifyListeners();

    final result = await _repo.getPlaces();

    _isLoading = false;

    if (result.isFailure) {
      errorMessage = result.error;
      notifyListeners();
      return false;
    }

    notifyListeners();
    return true;
  }
}
