import 'package:flutter/material.dart';
import 'package:games_app/controllers/games_controller.dart';
import 'package:games_app/pages/home_page.dart';
import 'package:get_it/get_it.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    this._registerStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

  _registerStores() {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton(GamesController());
  }
}
