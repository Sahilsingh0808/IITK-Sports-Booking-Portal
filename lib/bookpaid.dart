// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:gnsdev/profile.dart';
import 'package:gnsdev/remedy.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'info.dart';

class BookPaid extends StatefulWidget {
  const BookPaid({Key? key}) : super(key: key);

  @override
  _BookPaidState createState() => _BookPaidState();
}

class _BookPaidState extends State<BookPaid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    getDetails();

    print(" user " + userEmail!);
  }

  DateTime currentDate = DateTime.now();
  String? userEmail = '', userName = '', userRoll = '';
  List<String> depList = [];
  late SimpleFontelicoProgressDialog _dialog;
  DateTime currentDate1 = DateTime.now();
  bool? isStudent;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');
  String? data1, temp = "Confirm Seat";
  int? seats;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  String? _chosenValue, _chosenValue2, valueText, pickedDate;
  late int _currentValue = 0;
  final navigatorKey = GlobalKey<NavigatorState>();
  Future<void> _selectDate(BuildContext context) async {
    DateTime last = currentDate.add(const Duration(days: 2));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: currentDate1,
        lastDate: last);
    if (picked != null) {
      setState(() {
        currentDate = picked;
        pickedDate =
            currentDate.month.toString() + "_" + currentDate.year.toString();
        _dateController.text = DateFormat.yMd().format(currentDate);
      });
    }
  }

  Future sendEmail(
      {required String facility,
      required String date,
      required String slot,
      required String name,
      required String email,
      required String time,
      required String subject,
      required String message}) async {
    const String serviceID = 'service_t1yuekz';
    const String templateID = 'template_ydlj5s4';
    const String userID = 'user_Rgq3HtaCMu8ckNNNPVR0T';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceID,
          'template_id': templateID,
          'user_id': userID,
          'template_params': {
            'user_name': name,
            'user_time': time,
            'user_facility': facility,
            'user_slot': slot,
            'user_date': date,
            'user_email': email.toLowerCase(),
            'user_subject': subject,
            'user_message': message,
            'reply_to': '',
          }
        }));
    // ignore: avoid_print
    print(response.body);
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("hi"),
            ));
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
      navigatorKey: navigatorKey,
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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Info()));
                  });
            }),
            const SizedBox(width: 20),
            Builder(builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  });
            }),
            const SizedBox(width: 50),
          ],
          title: const Text("Book your slot"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 500,
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
                          const SizedBox(
                            height: 20,
                          ),
                          Builder(builder: (context) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("You can register below"),
                            );
                          }),
                          // Builder(builder: (context) {
                          //   return ElevatedButton(
                          //     onPressed: () => _selectDate(context),
                          //     child: Text(
                          //         "${currentDate.day}/${currentDate.month}/${currentDate.year}"),
                          //   );
                          // }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: _chosenValue,
                              //elevation: 5,
                              style: const TextStyle(color: Colors.black),

                              items: <String>[
                                'Gym MWF (New Sports Complex)',
                                'Gym TThS (New Sports Complex)',
                                'Gym MWF (Old Sports Complex)',
                                'Gym TThS (Old Sports Complex)',
                                'Wall Climbing MWF (New Sports Complex)',
                                'Wall Climbing TThS (New Sports Complex)',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: const Text(
                                "Please choose a facility",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              onChanged: (value) {
                                assert(value != null);
                                setState(() {
                                  _chosenValue = value!;
                                });
                              },
                            ),
                          ),
                          DropdownButton<String>(
                            value: _chosenValue2,
                            //elevation: 5,
                            style: const TextStyle(color: Colors.black),

                            items: <String>[
                              '06.30-07.20 AM',
                              '07.30-08.20 AM',
                              '08.30-09.20 AM',
                              '09.30-10.20 AM',
                              '10.30-11.20 AM',
                              '11.30-12.20 PM',
                              '03.00-03.50 PM',
                              '04.00-04.50 PM',
                              '05.00-05.50 PM',
                              '06.00-06.50 PM',
                              '07.00-07.50 PM',
                              '08.00-08.50 PM',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: const Text(
                              "Please choose a time slot",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: (value) {
                              assert(value != null);
                              setState(() {
                                _chosenValue2 = value!;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Builder(builder: (context) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Color(0xFF7D95FF),
                              onTap: () {
                                check(_chosenValue, _chosenValue2);
                              },
                              child: Ink(
                                  color: Color(0xFF0029E2),
                                  width: 200,
                                  height: 50,
                                  child: const Center(
                                      child: Text(
                                    'Check availabilty',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))),
                            );
                          }),
                          const SizedBox(
                            height: 25,
                          ),
                          Builder(builder: (context) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Color(0xFF7D95FF),
                              onTap: () {
                                validate(_chosenValue, _chosenValue2);
                              },
                              child: Ink(
                                  color: Color(0xFF0029E2),
                                  width: 200,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    temp!,
                                    textScaleFactor: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))),
                            );
                          }),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Timings:\n\nGym: 6:30 AM - 12:20 PM and 03:00 PM - 08:50 PM\nWall Climbing: 06:30 AM - 07:20 AM and 05:00 PM - 05:50 PM',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> check(String? chosenValue, String? chosenValue2) async {
    if (chosenValue == null && chosenValue2 == null) {
      print("hello");
      Fluttertoast.showToast(
        msg: "Please select ground and time slot",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      // ignore: prefer_const_constructors
      // _messangerKey.currentState!.showSnackBar(SnackBar(
      //   content: const Text("Please select ground and time slot"),
      // ));
    } else if (chosenValue == null && chosenValue2 != null) {
      Fluttertoast.showToast(
        msg: "Please select facility",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue2 == null && chosenValue != null) {
      Fluttertoast.showToast(
        msg: "Please select time slot",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue!.contains('Wall Climbing') &&
        (chosenValue2!.contains('07.30-08.20 AM') ||
            chosenValue2!.contains('08.30-09.20 AM') ||
            chosenValue2!.contains('09.30-10.20 AM') ||
            chosenValue2!.contains('10.30-11.20 AM') ||
            chosenValue2!.contains('11.30-12.20 PM') ||
            chosenValue2!.contains('03.00-03.50 PM') ||
            chosenValue2!.contains('04.00-04.50 PM') ||
            chosenValue2!.contains('07.00-07.50 PM') ||
            chosenValue2!.contains('06.00-06.50 PM') ||
            chosenValue2!.contains('08.00-08.50 PM'))) {
      Fluttertoast.showToast(
        msg: "This slot is not available for booking",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue!.contains('Billiards Room') &&
        (chosenValue2!.contains('08.30-09.20 AM') ||
            chosenValue2!.contains('09.30-10.20 AM') ||
            chosenValue2!.contains('10.30-11.20 AM') ||
            chosenValue2!.contains('11.30-12.20 PM') ||
            chosenValue2!.contains('03.00-03.50 PM') ||
            chosenValue2!.contains('04.00-04.50 PM') ||
            chosenValue2!.contains('07.00-07.50 PM') ||
            chosenValue2!.contains('08.00-08.50 PM'))) {
      Fluttertoast.showToast(
        msg: "This slot is not available for booking",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      try {
        var collection = FirebaseFirestore.instance.collection('bookings');
        var docSnapshot = await collection
            .doc(_chosenValue.toString())
            .collection(currentDate.month.toString() +
                "_" +
                currentDate.year.toString())
            .doc(_chosenValue2.toString())
            .get();
        print("Reached 1");
        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          // You can then retrieve the value from the Map like this:
          seats = data?['seats'];
          print("Reached 2");
          if (seats! <= 0) {
            showError("No seats available");
          } else {
            print("Reached 3");
            showSuccess(
                "Slot Availabilty", "Available seats: " + seats.toString());
          }
        } else {
          showError("No slots available");
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  showSuccess(String tittle, String successmessage) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: tittle,
        desc: successmessage,
        btnOkColor: const Color(0xFF0029E2),
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
  }

  Future<void> validate(String? chosenValue, String? chosenValue2) async {
    print(chosenValue! + chosenValue2! + "   CHECK");
    if (chosenValue == null && chosenValue2 == null) {
      print("hello");
      Fluttertoast.showToast(
        msg: "Please select ground and time slot",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      // ignore: prefer_const_constructors
      // _messangerKey.currentState!.showSnackBar(SnackBar(
      //   content: const Text("Please select ground and time slot"),
      // ));
    } else if (chosenValue == null && chosenValue2 != null) {
      Fluttertoast.showToast(
        msg: "Please select ground",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue2 == null && chosenValue != null) {
      Fluttertoast.showToast(
        msg: "Please select time slot",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue!.contains('Wall Climbing') &&
        (chosenValue2!.contains('07.30-08.20 AM') ||
            chosenValue2!.contains('08.30-09.20 AM') ||
            chosenValue2!.contains('09.30-10.20 AM') ||
            chosenValue2!.contains('10.30-11.20 AM') ||
            chosenValue2!.contains('11.30-12.20 PM') ||
            chosenValue2!.contains('03.00-03.50 PM') ||
            chosenValue2!.contains('04.00-04.50 PM') ||
            chosenValue2!.contains('07.00-07.50 PM') ||
            chosenValue2!.contains('08.00-08.50 PM'))) {
      Fluttertoast.showToast(
        msg: "This slot is not available for booking",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (chosenValue!.contains('Billiards Room') &&
        (chosenValue2!.contains('08.30-09.20 AM') ||
            chosenValue2!.contains('09.30-10.20 AM') ||
            chosenValue2!.contains('10.30-11.20 AM') ||
            chosenValue2!.contains('11.30-12.20 PM') ||
            chosenValue2!.contains('03.00-03.50 PM') ||
            chosenValue2!.contains('04.00-04.50 PM') ||
            chosenValue2!.contains('06.00-06.50 PM') ||
            chosenValue2!.contains('07.00-07.50 PM') ||
            chosenValue2!.contains('08.00-08.50 PM'))) {
      Fluttertoast.showToast(
        msg: "This slot is not available for booking",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      try {
        DateTime date1 = DateTime.now();
        pickedDate = date1.month.toString() + "_" + date1.year.toString();
        String name = '';
        var collection = FirebaseFirestore.instance.collection('bookings');
        var docSnapshot = await collection
            .doc(_chosenValue.toString())
            .collection(currentDate.month.toString() +
                "_" +
                currentDate.year.toString())
            .doc(_chosenValue2.toString())
            .get();
        print("Reached 1");
        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          // You can then retrieve the value from the Map like this:
          seats = data?['seats'];
          print("Reached 2");
          if (seats! <= 0) {
            showError("No seats available");
          } else {
            print("Reached 3");
            try {
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) {
              //       Future.delayed(const Duration(seconds: 2), () {
              //         Navigator.of(context).pop(true);
              //       });
              //       return const AlertDialog(
              //         title: Text(
              //             'Please wait while your booking is being confirmed'),
              //       );
              //     });
              var collection =
                  FirebaseFirestore.instance.collection('bookings');
              var docSnapshot = await collection
                  .doc(_chosenValue.toString())
                  .collection(currentDate.month.toString() +
                      "_" +
                      currentDate.year.toString())
                  .doc(_chosenValue2.toString())
                  .get();
              print("Reached 1");
              if (docSnapshot.exists) {
                Map<String, dynamic>? data = docSnapshot.data();
                // You can then retrieve the value from the Map like this:
                seats = data?['seats'];
                print("Reached 2");
                if (seats! <= 0) {
                  showError("No seats available");
                } else {
                  print("Reached 3");
                  print(_chosenValue.toString() +
                      " " +
                      _chosenValue2.toString() +
                      " " +
                      pickedDate.toString());
                  var res1 = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userEmail)
                      .get();
                  String paid = '';
                  String paidWC = '';
                  String paidB = '';
                  paid = res1.data()!['paid'] == null
                      ? 'NULL'
                      : res1.data()!['paid'];
                  paidWC = res1.data()!['paidWC'] == null
                      ? 'NULL'
                      : res1.data()!['paidWC'];
                  if (paid.isEmpty || paid == null || paid == 'NULL') {
                    paid = '-1';
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userEmail)
                        .update({'paid': '-1'});
                  }
                  if (paidWC.isEmpty || paidWC == null || paidWC == 'NULL') {
                    paidWC = '-1';
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userEmail)
                        .update({'paidWC': '-1'});
                  }
                  paidB = res1.data()!['paidB'];
                  if (chosenValue!.contains('Gym') ||
                      chosenValue!.contains('Cardio')) {
                    if (paid.length <= 2) {
                      showSuccess('Booking Successful',
                          'Your booking has been confirmed');
                      String month = '';
                      if (currentDate.month.toString() == '12') {
                        month = 'December';
                      } else if (currentDate.month.toString() == '1') {
                        month = 'January';
                      } else if (currentDate.month.toString() == '2') {
                        month = 'February';
                      } else if (currentDate.month.toString() == '3') {
                        month = 'March';
                      } else if (currentDate.month.toString() == '4') {
                        month = 'April';
                      } else if (currentDate.month.toString() == '5') {
                        month = 'May';
                      } else if (currentDate.month.toString() == '6') {
                        month = 'June';
                      } else if (currentDate.month.toString() == '7') {
                        month = 'July';
                      } else if (currentDate.month.toString() == '8') {
                        month = 'August';
                      } else if (currentDate.month.toString() == '9') {
                        month = 'September';
                      } else if (currentDate.month.toString() == '10') {
                        month = 'October';
                      } else if (currentDate.month.toString() == '11') {
                        month = 'November';
                      }
                      final df = DateFormat('dd-MM-yyyy hh:mm a');
                      int myvalue =
                          (((DateTime.now()).millisecondsSinceEpoch) / 1000)
                              .round();
                      sendEmail(
                          name: userName!,
                          email: userEmail!,
                          facility: chosenValue.toString(),
                          slot: chosenValue2.toString(),
                          date: month,
                          time: df.format(DateTime.fromMillisecondsSinceEpoch(
                              myvalue * 1000)),
                          message:
                              'Your booking has been confirmed. The details are as follows:',
                          subject:
                              'Booking Confirmation for Sports Facilities IITK');

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userEmail)
                          .update({
                        'paid': currentDate.month.toString() +
                            "_" +
                            currentDate.year.toString()
                      });
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(userEmail)
                          .collection('user bookings')
                          .doc('Booking%%' +
                              _chosenValue.toString() +
                              "%%" +
                              pickedDate! +
                              "%%" +
                              _chosenValue2.toString())
                          .set({
                        'ground': _chosenValue.toString(),
                        'date': pickedDate,
                        'slot': _chosenValue2.toString(),
                        'accompany': '0',
                        'emails': userEmail,
                        'accompany details': userName
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .update({
                        'seats': seats! - 1,
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .collection('names')
                          .doc(userEmail! + '%' + userName!)
                          .set({
                        'name': userName,
                        'email': userEmail,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    } else {
                      showError(
                          "You have already registered for a Gym/Cardio facility this month");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    }
                  } else if ((chosenValue!.contains('Wall Climbing'))) {
                    if (paidWC.length <= 2) {
                      showSuccess('Booking Successful',
                          'Your booking has been confirmed');
                      String month = '';
                      if (currentDate.month.toString() == '12') {
                        month = 'December';
                      } else if (currentDate.month.toString() == '1') {
                        month = 'January';
                      } else if (currentDate.month.toString() == '2') {
                        month = 'February';
                      } else if (currentDate.month.toString() == '3') {
                        month = 'March';
                      } else if (currentDate.month.toString() == '4') {
                        month = 'April';
                      } else if (currentDate.month.toString() == '5') {
                        month = 'May';
                      } else if (currentDate.month.toString() == '6') {
                        month = 'June';
                      } else if (currentDate.month.toString() == '7') {
                        month = 'July';
                      } else if (currentDate.month.toString() == '8') {
                        month = 'August';
                      } else if (currentDate.month.toString() == '9') {
                        month = 'September';
                      } else if (currentDate.month.toString() == '10') {
                        month = 'October';
                      } else if (currentDate.month.toString() == '11') {
                        month = 'November';
                      }
                      final df = DateFormat('dd-MM-yyyy hh:mm a');
                      int myvalue =
                          (((DateTime.now()).millisecondsSinceEpoch) / 1000)
                              .round();

                      sendEmail(
                          name: userName!,
                          email: userEmail!,
                          date: month,
                          facility: chosenValue.toString(),
                          slot: chosenValue2.toString(),
                          time: df.format(DateTime.fromMillisecondsSinceEpoch(
                              myvalue * 1000)),
                          message:
                              'Your booking has been confirmed. The details are as follows:',
                          subject:
                              'Booking Confirmation for Sports Facilities IITK');

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userEmail)
                          .update({
                        'paidWC': currentDate.month.toString() +
                            "_" +
                            currentDate.year.toString()
                      });
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(userEmail)
                          .collection('user bookings')
                          .doc('Booking%%' +
                              _chosenValue.toString() +
                              "%%" +
                              pickedDate! +
                              "%%" +
                              _chosenValue2.toString())
                          .set({
                        'ground': _chosenValue.toString(),
                        'date': pickedDate,
                        'slot': _chosenValue2.toString(),
                        'accompany': '0',
                        'emails': userEmail,
                        'accompany details': userName
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .update({
                        'seats': seats! - 1,
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .collection('names')
                          .doc(userEmail! + '%' + userName!)
                          .set({
                        'name': userName,
                        'email': userEmail,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    } else {
                      showError(
                          "You have already registered for a Wall Climbing facility this month");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    }
                  } else if ((chosenValue!.contains('Billiards'))) {
                    if (paidB.length <= 2) {
                      showSuccess('Booking Successful',
                          'Your booking has been confirmed');
                      String month = '';
                      if (currentDate.month.toString() == '12') {
                        month = 'December';
                      } else if (currentDate.month.toString() == '1') {
                        month = 'January';
                      } else if (currentDate.month.toString() == '2') {
                        month = 'February';
                      } else if (currentDate.month.toString() == '3') {
                        month = 'March';
                      } else if (currentDate.month.toString() == '4') {
                        month = 'April';
                      } else if (currentDate.month.toString() == '5') {
                        month = 'May';
                      } else if (currentDate.month.toString() == '6') {
                        month = 'June';
                      } else if (currentDate.month.toString() == '7') {
                        month = 'July';
                      } else if (currentDate.month.toString() == '8') {
                        month = 'August';
                      } else if (currentDate.month.toString() == '9') {
                        month = 'September';
                      } else if (currentDate.month.toString() == '10') {
                        month = 'October';
                      } else if (currentDate.month.toString() == '11') {
                        month = 'November';
                      }
                      final df = DateFormat('dd-MM-yyyy hh:mm a');
                      int myvalue =
                          (((DateTime.now()).millisecondsSinceEpoch) / 1000)
                              .round();

                      sendEmail(
                          name: userName!,
                          email: userEmail!,
                          facility: chosenValue.toString(),
                          slot: chosenValue2.toString(),
                          date: month,
                          time: df.format(DateTime.fromMillisecondsSinceEpoch(
                              myvalue * 1000)),
                          message:
                              'Your booking has been confirmed. The details are as follows:',
                          subject:
                              'Booking Confirmation for Sports Facilities IITK');

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(userEmail)
                          .update({
                        'paidB': currentDate.month.toString() +
                            "_" +
                            currentDate.year.toString()
                      });
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(userEmail)
                          .collection('user bookings')
                          .doc('Booking%%' +
                              _chosenValue.toString() +
                              "%%" +
                              pickedDate! +
                              "%%" +
                              _chosenValue2.toString())
                          .set({
                        'ground': _chosenValue.toString(),
                        'date': pickedDate,
                        'slot': _chosenValue2.toString(),
                        'accompany': '0',
                        'emails': userEmail,
                        'accompany details': userName
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .update({
                        'seats': seats! - 1,
                      });
                      await FirebaseFirestore.instance
                          .collection("bookings")
                          .doc(_chosenValue.toString())
                          .collection(pickedDate!)
                          .doc(_chosenValue2.toString())
                          .collection('names')
                          .doc(userEmail! + '%' + userName!)
                          .set({
                        'name': userName,
                        'email': userEmail,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    } else {
                      showError(
                          "You have already registered for a Billiards facility this month");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                    }
                  }
                }
              } else {
                showError("No slots available");
              }
            } catch (e) {
              showError(e.toString());
            }
          }
        } else {
          showError("No slots available");
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  getDetails() async {
    var res = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();

    setState(() {
      userName = res.data()!['name'];
      userRoll = res.data()!['roll'];
    });
  }
}
