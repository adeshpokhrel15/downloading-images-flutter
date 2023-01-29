import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PhotosPage extends StatefulWidget {
  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  Future<Database> _createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/photos.db";
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE photos (albumId INTEGER, id INTEGER PRIMARY KEY, title TEXT)");
    });
  }

  Future<void> insertPhoto(int albumId, int id, String title) async {
    final db = await _createDatabase();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert(
          "INSERT INTO photos (albumId, id, title) VALUES ($albumId, $id, '$title')");
    });
  }

  Future<List<Map<String, dynamic>>> getPhotos() async {
    final db = await _createDatabase();
    return await db.rawQuery("SELECT * FROM photos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPhotos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> photo = snapshot.data![index];
              return ListTile(
                title: Text("Album ID: ${photo['albumId']}"),
                subtitle: Text("ID: ${photo['id']}\nTitle: ${photo['title']}"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await http
              .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
          final List<dynamic> photos = json.decode(response.body);
          for (var photo in photos) {
            await insertPhoto(photo["albumId"], photo["id"], photo["title"]);
          }
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
