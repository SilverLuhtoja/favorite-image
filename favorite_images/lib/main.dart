import 'package:favorite_images/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Library',
      debugShowCheckedModeBanner: false,
      home: Navigator(
        pages: const [
          MaterialPage(child: HomePage()),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          return true;
        },
      ),
    );
  }
}
