import 'dart:async';
import 'dart:io';

import 'package:globe_trek/core/services/popular_places_service.dart';
import 'package:globe_trek/core/utils/result.dart';

class PopularPlacesRepository {
  final PopularPlacesService _service = PopularPlacesService();

  Future<Result> getPlaces() async {
    try {
      final result = await _service.fetchPlaces();
      return Result.success(result);
    } on TimeoutException {
      return Result.failure("Request timed out. Please try again.");
    } on SocketException {
      return Result.failure("No internet connection.");
    } catch (e) {
      return Result.failure("Something went wrong.");
    }
  }
}
