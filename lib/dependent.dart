// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:gnsdev/book.dart';
// import 'package:gnsdev/profile.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'dashboard.dart';
// import 'info.dart';

// class Dependent extends StatefulWidget {
//   const Dependent({Key? key}) : super(key: key);

//   @override
//   _DependentState createState() => _DependentState();
// }

// class _DependentState extends State<Dependent> {
//   String _chosen = '';
//   @override
//   Widget build(BuildContext context) {
//     TextStyle defaultStyle =
//         const TextStyle(color: Colors.white60, fontSize: 15.0);
//     TextStyle linkStyle = const TextStyle(
//         color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic);
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             bottomNavigationBar: BottomAppBar(
//               color: Colors.black,
//               child: SizedBox(
//                   height: 26,
//                   child: Center(
//                     child: RichText(
//                       text: TextSpan(
//                         style: defaultStyle,
//                         children: <TextSpan>[
//                           const TextSpan(text: 'Developed by '),
//                           TextSpan(
//                               text: 'Sahil Singh',
//                               style: linkStyle,
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   launch(
//                                       'https://home.iitk.ac.in/~sahilsingh20/');
//                                 }),
//                           // const TextSpan(text: '  For any '),
//                           // TextSpan(
//                           //     text: 'Technical Assistance or Feedback',
//                           //     style: linkStyle,
//                           //     recognizer: TapGestureRecognizer()
//                           //       ..onTap = () {
//                           //         launch('');
//                           //       }),
//                         ],
//                       ),
//                     ),
//                   )),
//               elevation: 5,
//             ),
//             appBar: AppBar(
//               actions: [
//                 Builder(builder: (context) {
//                   return IconButton(
//                       icon: const Icon(Icons.info_outline_rounded),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Info()));
//                       });
//                 }),
//                 const SizedBox(width: 20),
//                 Builder(builder: (context) {
//                   return IconButton(
//                       icon: const Icon(Icons.person),
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Profile()));
//                       });
//                 }),
//                 const SizedBox(width: 50),
//               ],
//               title: const Text("Fill in your compananions' details"),
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () => Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => const Dashboard())),
//               ),
//             ),
//             body: Column(
//               children: [
//                 const Text(
//                   'Please select whatever applies to you',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DropdownButton<String>(
//                     value: _chosen,
//                     //elevation: 5,
//                     style: const TextStyle(color: Colors.black),

//                     items: <String>['Myself', 'My dependents']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     hint: const Text(
//                       "Who would you like to make a booking for?",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     onChanged: (value) {
//                       assert(value != null);
//                       setState(() {
//                         _chosen = value!;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Builder(builder: (context) {
//                   return InkWell(
//                     borderRadius: BorderRadius.circular(10),
//                     splashColor: Colors.green,
//                     onTap: () {
//                       check(_chosen);
//                     },
//                     child: Ink(
//                         color: Colors.greenAccent,
//                         width: 200,
//                         height: 50,
//                         child: const Center(
//                             child: Text(
//                           'Proceed',
//                           textScaleFactor: 1,
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ))),
//                   );
//                 }),
//               ],
//             )));
//   }

//   void check(String chosen) {
//     if (chosen.isEmpty || chosen == null) {
//       showError('Please choose a service');
//     } else {
//       if (chosen == 'Myself') {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const BookSlot(title: 'Book your seat')));
//       } else {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ()));
//       }
//     }
//   }

//   showError(String errormessage) {
//     AwesomeDialog(
//             context: context,
//             dialogType: DialogType.ERROR,
//             animType: AnimType.RIGHSLIDE,
//             headerAnimationLoop: true,
//             title: 'Error',
//             desc: errormessage,
//             btnOkOnPress: () {},
//             btnOkIcon: Icons.cancel,
//             btnOkColor: Colors.red)
//         .show();
//   }
// }
