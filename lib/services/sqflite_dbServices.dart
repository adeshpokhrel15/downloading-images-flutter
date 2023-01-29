import 'dart:convert';

import 'package:http/http.dart' as http;

class SqfliteDatabase {
  Future<List<Map<String, dynamic>>> fetchPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if (response.statusCode == 200) {
      List<dynamic> photosJson = json.decode(response.body);
      List<Map<String, dynamic>> photos = [];
      for (var photoJson in photosJson) {
        photos.add({
          "id": photoJson["id"],
          "albumId": photoJson["albumId"],
          "title": photoJson["title"],
        });
      }
      return photos;
    } else {
      throw Exception("Failed to retrieve photos");
    }
  }
}
