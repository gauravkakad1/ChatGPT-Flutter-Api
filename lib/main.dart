import 'package:chatgpt_flutter_app/palletes.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT App',
      theme: ThemeData.light(useMaterial3: true).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: const HomeScreen(),
    );
  }
}
