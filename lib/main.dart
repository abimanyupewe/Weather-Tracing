import 'package:flutter/material.dart';

import 'Pages/home.dart';
import 'Widgets/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
      future: Future.delayed(
        Duration(seconds: 3),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
      },
    );
  }
}
