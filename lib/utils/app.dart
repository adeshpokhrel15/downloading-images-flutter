import 'package:downloader_flutter/bloc/app_bloc.dart';
import 'package:downloader_flutter/services/data_services.dart';
import 'package:downloader_flutter/views/sqflite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(UserDataSource()),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: PhotosPage()),
    );
  }
}
