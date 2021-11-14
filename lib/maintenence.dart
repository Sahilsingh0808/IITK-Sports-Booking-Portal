import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'info.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({Key? key}) : super(key: key);

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
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
          // actions: [
          //   Builder(builder: (context) {
          //     return IconButton(
          //         icon: const Icon(Icons.info_outline_rounded),
          //         onPressed: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => const Info()));
          //         });
          //   }),
          // ],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("IITK Sports Facilities Booking Portal"),
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'WEBSITE IS UNDER MAINTENANCE.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
