import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/ui/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fontFamily: "PressStart2P",
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
