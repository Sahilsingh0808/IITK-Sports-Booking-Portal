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
            //   actions: [
            //   Builder(builder: (context) {
            //     return IconButton(
            //         icon: const Icon(Icons.info_outline_rounded),
            //         onPressed: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => const Info()));
            //         });
            //   }),
            //   const SizedBox(width: 50),
            // ],
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("IITK Sports Facilities Booking Portal"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: NetworkImage('https://i.ibb.co/pnhyybJ/mainpage.jpg'),
                // image: NetworkImage(
                //     'https://centralindia1-mediap.svc.ms/transform/thumbnail?provider=spo&inputFormat=jpg&cs=fFNQTw&docid=https%3A%2F%2Fiitk-my.sharepoint.com%3A443%2F_api%2Fv2.0%2Fdrives%2Fb!CUtOARYXTUOwHC3msPiu55JOoE0ZrxBFvzUvBTfa9fK-fMyy-E_0SLO2gwxTn9VH%2Fitems%2F01DK6H5GNGARVAEHY3BNFL4VY3DRIE4IAY%3Fversion%3DPublished&access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvaWl0ay1teS5zaGFyZXBvaW50LmNvbUA5ZWJjZDgyYi0zYTcxLTQ5YmYtODkxZS04NmQ4MTlhMDkxMWMiLCJpc3MiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAiLCJuYmYiOiIxNjM2NjIxMjAwIiwiZXhwIjoiMTYzNjY0MjgwMCIsImVuZHBvaW50dXJsIjoiS20rRHNYWWQ5Z0QzalRuQXNVakRCL3ZBTEVBek42WkFWSXovTHJOVnRqND0iLCJlbmRwb2ludHVybExlbmd0aCI6IjExNCIsImlzbG9vcGJhY2siOiJUcnVlIiwidmVyIjoiaGFzaGVkcHJvb2Z0b2tlbiIsInNpdGVpZCI6Ik1ERTBaVFJpTURrdE1UY3hOaTAwTXpSa0xXSXdNV010TW1SbE5tSXdaamhoWldVMyIsIm5hbWVpZCI6IjAjLmZ8bWVtYmVyc2hpcHx1cm4lM2FzcG8lM2Fhbm9uIzQ0NDhhNGM2MmUwMmQxY2ZjNmY3Y2JlYzM2OGFiNzBjMmM2OTc4NjI2MjJlOGE5YTEzNmNkMGJhMWQ1ZGZjZjYiLCJuaWkiOiJtaWNyb3NvZnQuc2hhcmVwb2ludCIsImlzdXNlciI6InRydWUiLCJjYWNoZWtleSI6IjBoLmZ8bWVtYmVyc2hpcHx1cm4lM2FzcG8lM2Fhbm9uIzQ0NDhhNGM2MmUwMmQxY2ZjNmY3Y2JlYzM2OGFiNzBjMmM2OTc4NjI2MjJlOGE5YTEzNmNkMGJhMWQ1ZGZjZjYiLCJzaGFyaW5naWQiOiJUc0tpS04rKzhVU2Y2WXBEZFRWRW5nIiwidHQiOiIwIiwidXNlUGVyc2lzdGVudENvb2tpZSI6IjIiLCJpcGFkZHIiOiIxNC4xMzkuMzguMTM3In0.ZTZySjRvc0dxZkV0WGhBWXR1bUM5b29uSVNoclB2djRiZjlWbFM2NTZKOD0&cTag=%22c%3A%7B026A04A6-1B1F-4A0B-BE57-1B1C504E2018%7D%2C2%22&encodeFailures=1&width=1254&height=838&srcWidth=6016&srcHeight=4016'),
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://i.ibb.co/pnhyybJ/mainpage.jpg'),
                //       image: NetworkImage(
                //           'https://i.ibb.co/jzx8vHz/f5754d80-4259-453a-905d-84f90e303b9e.jpg')),
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
