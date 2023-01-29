import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/data_model.dart';

class UserDataSource {
  static const url = 'https://jsonplaceholder.typicode.com/photos';

//get User

  Future<List<UserModel>> getUser() async {
    var response = await http.get(Uri.parse(url));
    Iterable userList = json.decode(response.body);
    List<UserModel> users =
        userList.map((user) => UserModel.fromJson(user)).toList();
    // for (var u in users) {
    //   //download the user file
    //   await downloadFile(u.thumbnailUrl, u.id);
    // }

    return users;
  }

  // Future downloadFile(String url, int id) async {
  //   Directory? dir = await getExternalStorageDirectory();
  //   print(dir);
  //   FlutterDownloader.enqueue(
  //       url: url, savedDir: dir!.path, fileName: id.toString());
  // }
}
// List<FileSystemEntity> _images = [];
// dynamic downloadPath() async {
//   // Get the external storage directory
//   final directory = await getExternalStorageDirectory();
//   print('hahah');
//   print(directory);

//   // Fetch all the images in the directory
//   _images = Directory(directory!.path)
//       .listSync()
//       .where((entity) =>
//           entity.path.endsWith('.jpg') || entity.path.endsWith('.png'))
//       .toList();
// }


