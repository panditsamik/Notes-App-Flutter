import 'package:flutter/material.dart';
import 'package:notes/home_screen.dart';
import 'package:notes/home_page.dart';

import 'home_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: HomePage.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        HomePage.id: (context) => HomePage(),
      },
    ),
  );
}
