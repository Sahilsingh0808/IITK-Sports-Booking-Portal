// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer _timer;

  void startTimer() {
    Timer(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'IITK Sports Facilities Booking Portal',
                  )));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://img.wallpapersafari.com/desktop/1536/864/78/33/mi18Yw.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0029E2),
                          fontFamily: 'RaleWay'),
                      child: Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                                'IITK Sports Facilities Booking Portal'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
