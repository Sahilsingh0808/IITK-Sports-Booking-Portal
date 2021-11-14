// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/authentication/registercont.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class IndependentNumber extends StatefulWidget {
  const IndependentNumber({Key? key}) : super(key: key);

  @override
  _IndependentNumberState createState() => _IndependentNumberState();
}

class _IndependentNumberState extends State<IndependentNumber> {
  late int _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.white60, fontSize: 15.0);
    TextStyle linkStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.underline,
    );
    return MaterialApp(
      title: 'IITK Sports Facilities Booking Portal',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: SizedBox(
              height: 26,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: defaultStyle,
                      children: <TextSpan>[
                        const TextSpan(text: 'Developed by '),
                        TextSpan(
                            text: 'Sahil Singh',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://home.iitk.ac.in/~sahilsingh20/');
                              }),
                        const TextSpan(
                            text:
                                ' (Web Secretary, Games and Sports Council, IITK) '),
                        // const TextSpan(text: '  For any '),
                        // TextSpan(
                        //     text: 'Technical Assistance or Feedback',
                        //     style: linkStyle,
                        //     recognizer: TapGestureRecognizer()
                        //       ..onTap = () {
                        //         launch('');
                        //       }),
                      ],
                    ),
                  ),
                ),
              )),
          elevation: 5,
        ),
        appBar: AppBar(
          title: const Text('Choose number of dependents you have'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(15),
                //   image: DecorationImage(
                //       image: NetworkImage(
                //           "https://ak.picdn.net/shutterstock/videos/10042277/thumb/1.jpg"),
                //       fit: BoxFit.cover),
                // ),
                color: Colors.transparent,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 20,
                  shadowColor: Colors.white,
                  margin: const EdgeInsets.all(20),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide:
                    //     const BorderSide(color: Colors.blue, width: 2)
                  ),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: NumberPicker(
                            value: _currentValue,
                            minValue: 0,
                            maxValue: 10,
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              _currentValue = value;
                            }),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black26),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(builder: (context) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Color(0xFF5373FF),
                            onTap: () {
                              if (_currentValue == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Dashboard(),
                                    ));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterCont(
                                        people: _currentValue,
                                      ),
                                    ));
                              }
                            },
                            child: Ink(
                                color: Color(0xFF0029E2),
                                width: 200,
                                height: 50,
                                child: const Center(
                                    child: Text(
                                  'Next',
                                  textScaleFactor: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
