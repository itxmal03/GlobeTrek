import 'dart:convert';
import 'package:globe_trek/models/popular_places_model.dart';
import 'package:http/http.dart' as http;

class PopularPlacesService {
  final url =
      "https://raw.githubusercontent.com/itxmal03/public-json-apis/refs/heads/master/JSON%20APIs/popular_places.json";

  Future<List<PopularPlacesModel>> fetchPlaces() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body.toString());
      return jsonData.map((e) => PopularPlacesModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load places");
    }
  }
}
