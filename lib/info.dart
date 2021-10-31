import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.white60, fontSize: 15.0);
    TextStyle linkStyle = const TextStyle(
        color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          child: SizedBox(
              height: 26,
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
                              launch('https://home.iitk.ac.in/~sahilsingh20/');
                            }),
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
              )),
          elevation: 5,
        ),
        appBar: AppBar(
          actions: [
            SizedBox(width: 20),
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  });
            }),
            SizedBox(width: 50),
          ],
          title: const Text("Info"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            children: const [
              SizedBox(height: 100),
              Text(
                'Sports Booking Facility IITK',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                '©All Rights reserved',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              Text(
                'Special Thanks to: Mr. Syam Nair, Anshika Choudhary, Subham Gupta',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
              ),
              SizedBox(height: 10),
              Text(
                'Beta Testers: Navneet Singh, Sweta Kumari',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
