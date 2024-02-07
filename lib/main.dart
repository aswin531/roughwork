import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/splash.dart';

Future <void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await initaliseDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}