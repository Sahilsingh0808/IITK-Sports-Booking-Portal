// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authentication/login.dart';
import 'authentication/regsiter.dart';
import 'info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IITK Sports Facilities Booking Portal',
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: Colors.blueAccent,
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
            actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Info()));
                  });
            }),
            const SizedBox(width: 50),
          ],
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("IITK Sports Facilities Booking Portal"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.ibb.co/pnhyybJ/mainpage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: SizedBox(
                height: 270,
                width: 330,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: Builder(builder: (context) {
                            return ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFF0029E2)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color: Color(0xFF0029E2))))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Builder(builder: (context) {
                                        return const Text(
                                          "SIGN UP",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        );
                                      }),
                                    ]));
                          }),
                        ),
                        // ignore: prefer_const_constructors
                        // Text(
                        //   'for new users',
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: Builder(builder: (context) {
                            return ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFF0029E2)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color: Color(0xFF0029E2))))),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Builder(builder: (context) {
                                        return const Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600),
                                        );
                                      }),
                                    ]));
                          }),
                        ),
                        // Text(
                        //   'for existing users',
                        //   style: TextStyle(color: Colors.white),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
