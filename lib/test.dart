import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');
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
        home: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  Scaffold(
                      bottomNavigationBar: BottomAppBar(
                        color: Colors.black,
                        child: SizedBox(
                            height: 26,
                            width: MediaQuery.of(context).size.width,
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
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => const Info()));
                        //         });
                        //   }),
                        //   const SizedBox(width: 50),
                        // ],
                        title: const Text("Please fill your details"),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context)
                              .pop('IITK Sports Facilities Booking Portal'),
                        ),
                      ),
                      body: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                              child: SingleChildScrollView(
                                  child: Container(
                            child: ElevatedButton(
                              onPressed: () {
                                update();
                              },
                              child: Text('Update'),
                            ),
                          )))))
                ]))));
  }

  Future<void> update() async {
    var list;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();
    list = querySnapshot.docs;

    //check if user already booked same slot or same ground on same day
    if (list != null) {
      for (var res in list) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(res.id)
            .update({'paidWC': '-1', 'paidB': '-1', 'paid': '-1'});
        print(res.id);
      }
    }
  }
}
