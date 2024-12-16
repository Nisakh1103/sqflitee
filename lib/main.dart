import 'package:flutter/material.dart';
import 'package:sqflitee/controller/home_screen_controller.dart';
import 'package:sqflitee/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomeScreenController.initializeDateBase();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
    );
  }
}