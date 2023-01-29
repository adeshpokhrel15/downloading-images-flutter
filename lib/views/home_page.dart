// import 'package:downloader_flutter/bloc/app_bloc.dart';
// import 'package:downloader_flutter/bloc/app_event.dart';
// import 'package:downloader_flutter/bloc/app_state.dart';
// import 'package:downloader_flutter/models/data_model.dart';
// import 'package:downloader_flutter/services/data_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int progress = 0;

//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<UserBloc>(context).add(const LoadingUserEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     UserDataSource userDataSource = UserDataSource();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bloc'),
//         actions: [
//           TextButton(onPressed: () {}, child: const Text('Downloaded Images'))
//         ],
//       ),
//       body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
//         if (state is UserLoadingState) {
//           return Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   // UserBloc().add(LoadingUserEvent)
//                   BlocProvider.of<UserBloc>(context)
//                       .add(const LoadingUserEvent());
//                 },
//                 child: const Text('Fetch Data')),
//           );
//         }
//         if (state is UserLoadedState) {
//           List<UserModel> usersList = state.users;
//           return ListView.builder(
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: SingleChildScrollView(
//                   child: Card(
//                       child: SizedBox(
//                           height: 20,
//                           child: Image.asset(downloadPath().toString()))),
//                 ),
//               );
//             },
//           );
//         }
//         return const Center(child: CircularProgressIndicator());
//       }),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Image> images = [];
    for (int i = 0; i < 10; i++) {
      String filePath =
          "/storage/emulated/0/Android/data/com.example.downloader_flutter/files/$i";
      var image = Image.file(File(filePath));
      images.add(image);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Binary to Image'),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(images.length, (index) {
            return images[index];
          }),
        ),
      ),
    );
  }
}
