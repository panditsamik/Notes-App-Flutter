import 'package:flutter/cupertino.dart';
import 'home_screen.dart';

class Task {
  Task({required this.text, this.check = false});
  String text;
  bool check;
}
