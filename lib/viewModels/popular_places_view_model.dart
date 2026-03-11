import 'package:flutter/material.dart';
import 'package:globe_trek/models/popular_places_model.dart';
import 'package:globe_trek/repositories/popular_places_repository.dart';

class PopularPlacesViewModel extends ChangeNotifier {
  final PopularPlacesRepository _repo = PopularPlacesRepository();
  bool _isLoading = false;
  String? errorMessage;

  List<PopularPlacesModel> _placesList = [];

  //getters
  bool get isLoading => _isLoading;
  List<PopularPlacesModel> get placesList => _placesList;

  Future<bool> getPlaces() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await _repo.getPlaces();
    _isLoading = false;

    if (result.isFailure) {
      errorMessage = result.error;
      notifyListeners();
      return false;
    }

    _placesList = result.data ?? [];
    notifyListeners();
    return true;
  }
}
