import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class PlacesAPIMethods {
  static Future<List<PlaceModel>?> getPlaces(String token) async {
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/places'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      List<PlaceModel> places = await jsonDecode(response.body).map((e) => PlaceModel.fromMap(e)).toList();
      return places;
    } else {
      return null;
    }
  }
}
