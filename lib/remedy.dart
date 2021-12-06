// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:marquee/marquee.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class Remedy extends StatefulWidget {
  const Remedy({Key? key}) : super(key: key);

  @override
  _RemedyState createState() => _RemedyState();
}

// showError(String errormessage) {
//   AwesomeDialog(
//           context: context,
//           dialogType: DialogType.ERROR,
//           animType: AnimType.RIGHSLIDE,
//           headerAnimationLoop: true,
//           title: 'Error',
//           desc: errormessage,
//           btnOkOnPress: () {},
//           btnOkIcon: Icons.cancel,
//           btnOkColor: Colors.red)
//       .show();
// }

late SimpleFontelicoProgressDialog _dialog;
String? userEmail = '';

// showSuccess(String successmessage) {
//   AwesomeDialog(
//       context: context,
//       animType: AnimType.LEFTSLIDE,
//       headerAnimationLoop: false,
//       dialogType: DialogType.SUCCES,
//       showCloseIcon: true,
//       title: 'Success',
//       desc: successmessage,
//       btnOkColor: const Color(0xFF0029E2),
//       btnOkOnPress: () {
//         debugPrint('OnClick');
//       },
//       btnOkIcon: Icons.check_circle,
//       onDissmissCallback: (type) {
//         debugPrint('Dialog Dissmiss from callback $type');
//       }).show();
// }

class _RemedyState extends State<Remedy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    check();
  }

  String? otp, email, password, password1, name, roll, phone, category;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool shouldButtonEnabled = true;
  int otpNo = 0;
  final formKey = GlobalKey<FormState>();
  late bool submitValid = false, verified = false;
  bool checkbox = false, student = false, showPassword = false;

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
          child: Stack(
            children: [
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
                      child: Column(children: [
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          child: SizedBox(
                              height: 900,
                              width: 500.0,
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
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                            'Please verify your data below to continue',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Form(
                                          key: formKey,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25.0,
                                                            right: 25.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                    child: SizedBox(
                                                      height: 50.0,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    'Full Name (as per ID Card)'),
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Name is required'
                                                                : validateName(
                                                                    value),
                                                        onChanged: (value) {
                                                          name = value;
                                                        },
                                                      ),
                                                    )),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25.0,
                                                            right: 25.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                    child: SizedBox(
                                                      height: 50.0,
                                                      child: TextFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    'Roll Number/PF Number (as per ID Card)'),
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Roll number is required'
                                                                : validateRoll(
                                                                    value),
                                                        onChanged: (value) {
                                                          roll = value;
                                                        },
                                                      ),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0,
                                                          right: 25.0,
                                                          top: 20.0,
                                                          bottom: 5.0),
                                                  child: SizedBox(
                                                    height: 50.0,
                                                    child: TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Mobile Number'),
                                                      validator: (value) => value!
                                                              .isEmpty
                                                          ? 'Mobile number is required'
                                                          : validateRoll(value),
                                                      onChanged: (value) {
                                                        phone = value;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: DropdownButton<String>(
                                                    value: category,
                                                    //elevation: 5,
                                                    style: const TextStyle(
                                                        color: Colors.black),

                                                    items: <String>[
                                                      'Student',
                                                      'Faculty/Staff',
                                                      'Project Employee'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    hint: const Text(
                                                      "Please choose a category",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    onChanged: (value) {
                                                      assert(value != null);
                                                      setState(() {
                                                        category = value!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      if (checkFields()) {
                                                        update(roll!, name!,
                                                            phone!, category);
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 40.0,
                                                        width: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(
                                                                  0xFF0029E2)
                                                              .withOpacity(1),
                                                        ),
                                                        child: const Center(
                                                            child: Text(
                                                                'Confirm',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ))))),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                    )),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
  }

  validateRoll(String value) {
    if (value.isEmpty) {
      return 'Roll number is required';
    }
  }

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  Future<void> update(
      String roll, String name, String phone, String? category) async {
    print(category);
    if (category == null) {
      showError('Please select a category');
      return;
    }
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .update({
        'name': name,
        'email': userEmail,
        'roll': roll,
        'phone': phone,
        'category': category,
        'paid': '-1',
        'paidWC': '-1',
        'paidB': '-1'
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } catch (e) {
      print(e);
      showError(e.toString());
    }
  }

  showError(String errormessage) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: errormessage,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  Future<void> check() async {
    var res = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();
    String paid = res.data()!['paid'];
    if (paid != '0') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    }
  }
}
