import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'home_screen.dart';
import 'main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 40, end: 200).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool animating = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.navigate_next_sharp,
            color: Colors.lightBlueAccent.shade700,
            size: 40.0,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              animating = true;
              Future.delayed(const Duration(seconds: 1), () {
                // deleayed code here
                Navigator.pushNamed(context, HomeScreen.id);
                animating = false;
              });
            });
          },
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: ModalProgressHUD(
          inAsyncCall: animating,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, .0),
                      child: Image(
                        image: AssetImage('images/notepad.png'),
                        height: animation.value,
                        width: animation.value,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    TypewriterAnimatedTextKit(
                      speed: Duration(milliseconds: 500),
                      text: const ['Notes'],
                      textStyle: const TextStyle(
                        fontSize: 70.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
