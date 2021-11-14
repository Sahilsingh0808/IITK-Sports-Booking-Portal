// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/profile.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'company.dart';
import 'company1.dart';
import 'info.dart';

class BookSlot extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();
  const BookSlot({Key? key, required String title}) : super(key: key);

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInput();
    userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    print(" user " + userEmail!);
    getDependents();
  }

  DateTime currentDate = DateTime.now();
  String? userEmail = '';
  List<String> depList = [];
  late SimpleFontelicoProgressDialog _dialog;
  DateTime currentDate1 = DateTime.now();

  bool? isStudent;
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var peopleCap = [
    16,
    16,
    16,
    35,
    35,
    6,
    6,
    4,
    4,
    4,
    16,
    16,
    16,
    6,
    6,
    6,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    20,
    20,
    6,
    6,
    6,
    6,
    6,
    6,
    30
  ];
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
        print(currentDate.weekday.toString() + "Sunday");
        pickedDate = currentDate.day.toString() +
            "_" +
            currentDate.month.toString() +
            "_" +
            currentDate.year.toString();
        _dateController.text = DateFormat.yMd().format(currentDate);
      });
    }
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
                              child: Text("You can book slots below"),
                            );
                          }),
                          Builder(builder: (context) {
                            return ElevatedButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                  "${currentDate.day}/${currentDate.month}/${currentDate.year}"),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: _chosenValue,
                              //elevation: 5,
                              style: const TextStyle(color: Colors.black),

                              items: <String>[
                                'Basketball 1 (Main Sports Stadium)',
                                'Basketball 2 (Main Sports Stadium)',
                                'Basketball 3 (Main Sports Stadium)',
                                'Badminton 1 (Old Sports Complex)',
                                'Badminton 2 (Old Sports Complex)',
                                'Squash 1 (Old Sports Complex)',
                                'Squash 2 (Old Sports Complex)',
                                'Volleyball 1 (Old Sports Complex)',
                                'Volleyball 2 (Old Sports Complex)',
                                'Volleyball 3 (Old Sports Complex)',
                                'Volleyball 4 (Old Sports Complex)',
                                'Tennis Wall (Old Sports Complex)',
                                'Badminton 1 (New Sports Complex)',
                                'Badminton 2 (New Sports Complex)',
                                'Badminton 3 (New Sports Complex)',
                                'Squash 1 (New Sports Complex)',
                                'Squash 2 (New Sports Complex)',
                                'Table Tennis 1 (New Sports Complex)',
                                'Table Tennis 2 (New Sports Complex)',
                                'Table Tennis 3 (New Sports Complex)',
                                'Table Tennis 4 (New Sports Complex)',
                                'Table Tennis 5 (New Sports Complex)',
                                'Table Tennis 6 (New Sports Complex)',
                                'Tennis 1 (Tennis Courts)',
                                'Tennis 2 (Tennis Courts)',
                                'Tennis 3 (Tennis Courts)',
                                'Tennis 4 (Tennis Courts)',
                                'Tennis 5 (Tennis Courts)',
                                'Tennis 6 (Tennis Courts)',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              hint: const Text(
                                "Please choose a sports ground",
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
                          (isStudent == true)
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Number of people accompanying you (excluding yourself):"),
                                )
                              : const SizedBox(
                                  width: 0,
                                ),
                          (isStudent == true)
                              ? NumberPicker(
                                  value: _currentValue,
                                  minValue: 0,
                                  maxValue: 10,
                                  step: 1,
                                  haptics: true,
                                  onChanged: (value) => setState(() {
                                    _currentValue = value;
                                    if (_currentValue > 0) {
                                      temp = "Next";
                                    } else {
                                      temp = "Confirm Seat";
                                    }
                                  }),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                )
                              : Container(),
                          (isStudent == true)
                              ? Text(
                                  'Selected Number of People: $_currentValue')
                              : Container(),
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

  Future<void> validate(String? chosenValue, String? chosenValue2) async {
    // print(chosenValue);
    DateTime _now = DateTime.now();
    String hour = _now.hour.toString();
    print("Hour" + hour);
    String date = _now.day.toString() +
        "_" +
        _now.month.toString() +
        "_" +
        _now.year.toString();
    print(date);
    String picked = currentDate.day.toString() +
        "_" +
        currentDate.month.toString() +
        "_" +
        currentDate.year.toString();
    print(picked);
    int hr = int.parse(hour);
    print("HOUR " + hr.toString());
    print(_chosenValue2.toString());

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
    } else if (_chosenValue2.toString() == '06.30-07.20 AM' &&
        hr >= 7 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '07.30-08.20 AM' &&
        hr >= 8 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '08.30-09.20 AM' &&
        hr >= 9 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '09.30-10.20 AM' &&
        hr >= 10 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '10.30-11.20 AM' &&
        hr >= 11 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '11.30-12.20 AM' &&
        hr >= 12 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '03.00-03.50 PM' &&
        hr >= 16 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '04.00-04.50 PM' &&
        hr >= 17 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '05.00-05.50 PM' &&
        hr >= 18 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '06.00-06.50 AM' &&
        hr >= 19 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '07.00-07.50 PM' &&
        hr >= 20 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '08.00-08.50 PM' &&
        hr >= 21 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (picked == '6_11_2021' || picked == '7_11_2021') {
      Fluttertoast.showToast(
        msg: "You can book from 8th November 2021",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString() ==
                'Basketball 1 (Main Sports Stadium)' ||
            _chosenValue.toString() == 'Basketball 2 (Main Sports Stadium)' ||
            _chosenValue.toString() == 'Basketball 2 (Main Sports Stadium)') &&
        (_chosenValue2.toString() == '03.00-03.50 PM' ||
            _chosenValue2.toString() == '04.00-04.50 PM' ||
            _chosenValue2.toString() == '09.30-10.20 AM' ||
            _chosenValue2.toString() == '10.30-11.20 AM' ||
            _chosenValue2.toString() == '11.30-12.20 PM')) {
      Fluttertoast.showToast(
        msg: "This combination for booking is not available.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Tennis Courts')) &&
        (_chosenValue2.toString() == '03.00-03.50 PM' ||
            _chosenValue2.toString() == '08.30-09.20 AM' ||
            _chosenValue2.toString() == '09.30-10.20 AM' ||
            _chosenValue2.toString() == '10.30-11.20 AM' ||
            _chosenValue2.toString() == '11.30-12.20 PM')) {
      Fluttertoast.showToast(
        msg: "This combination for booking is not available.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Tennis Courts') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "Tennis Courts are closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('New Sports Complex') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "New Sports Complex is closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Old Sports Complex') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "Old Sports Complex is closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      String? userEmail = '';
      var list;
      try {
        final User? user = FirebaseAuth.instance.currentUser;

        setState(() {
          userEmail = user?.email;
        });
        var res = await FirebaseFirestore.instance
            .collection('users')
            .doc(userEmail)
            .get();
        setState(() {
          isStudent = (res.data()!['category'] == 'Student') ? true : false;
        });
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .collection("user bookings")
            .get();
        list = querySnapshot.docs;
      } catch (e) {
        showError(e.toString());
      }

      //check if user already booked same slot or same ground on same day
      if (list != null) {
        for (var res in list) {
          String date = res.data()["date"];
          String ground = res.data()["ground"];
          String time = res.data()["slot"];
          print(date + " " + ground + " " + time);
          if (date ==
              currentDate.day.toString() +
                  "_" +
                  currentDate.month.toString() +
                  "_" +
                  currentDate.year.toString()) {
            Fluttertoast.showToast(
              msg:
                  "You have already booked on this day. Please select another day.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
            return;
          }
          // else if (date ==
          //         currentDate.day.toString() +
          //             "_" +
          //             currentDate.month.toString() +
          //             "_" +
          //             currentDate.year.toString() &&
          //     ground == chosenValue) {
          //   Fluttertoast.showToast(
          //     msg: "You have already booked this ground on this day",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //   );
          //   return;
          // } else if (time == chosenValue2.toString()) {
          //   Fluttertoast.showToast(
          //     msg: "You have already booked this slot on this day",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //   );
          //   return;
          // }
        }
      }
      if (isStudent == true) {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => SOF(
                  currentDate.day.toString() +
                      "_" +
                      currentDate.month.toString() +
                      "_" +
                      currentDate.year.toString(),
                  _chosenValue!,
                  _chosenValue2!,
                  _currentValue.toString(),
                )));
      } else {
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => SOF1(
                currentDate.day.toString() +
                    "_" +
                    currentDate.month.toString() +
                    "_" +
                    currentDate.year.toString(),
                _chosenValue!,
                _chosenValue2!,
                _currentValue.toString(),
                depList)));
      }

      //   try {
      //     await FirebaseFirestore.instance
      //         .collection("bookings")
      //         .doc(chosenValue2.toString())
      //         .get()
      //         .then((DocumentSnapshot snapshot) {
      //       if (snapshot.exists)
      //         print("NAME");
      //       else {
      //         showError("User not found");
      //       }
      //       setState(() {
      //         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      //         seats = data["seats"];
      //       });
      //     });
      //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     //   content: Text(name.toString()),
      //     // ));
      //   } catch (e) {
      //     showError(e.toString());
      //   }
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

  Future<void> check(chosenValue, chosenValue2) async {
    DateTime _now = DateTime.now();
    String hour = _now.hour.toString();
    print("Hour" + hour);
    String date = _now.day.toString() +
        "_" +
        _now.month.toString() +
        "_" +
        _now.year.toString();
    print(date);
    String picked = currentDate.day.toString() +
        "_" +
        currentDate.month.toString() +
        "_" +
        currentDate.year.toString();
    print(picked);
    int hr = int.parse(hour);
    print("HOUR " + hr.toString());
    print(_chosenValue2.toString());

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
    } else if (_chosenValue2.toString() == '06.30-07.20 AM' &&
        hr >= 7 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '07.30-08.20 AM' &&
        hr >= 8 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '08.30-09.20 AM' &&
        hr >= 9 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '09.30-10.20 AM' &&
        hr >= 10 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '10.30-11.20 AM' &&
        hr >= 11 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '11.30-12.20 AM' &&
        hr >= 12 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '03.00-03.50 PM' &&
        hr >= 16 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '04.00-04.50 PM' &&
        hr >= 17 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '05.00-05.50 PM' &&
        hr >= 18 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '06.00-06.50 AM' &&
        hr >= 19 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '07.00-07.50 PM' &&
        hr >= 20 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (_chosenValue2.toString() == '08.00-08.50 PM' &&
        hr >= 21 &&
        date == picked) {
      Fluttertoast.showToast(
        msg: "You cannot book a slot for the past",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (picked.toString() == '6_11_2021' ||
        picked.toString() == '7_11_2021') {
      Fluttertoast.showToast(
        msg: "You can book from 8th November 2021",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Tennis Courts') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "Tennis Courts are closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('New Sports Complex') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "New Sports Complex is closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Old Sports Complex') &&
        currentDate.weekday == 1)) {
      Fluttertoast.showToast(
        msg: "Old Sports Complex is closed on Sundays.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString() ==
                'Basketball 1 (Main Sports Stadium)' ||
            _chosenValue.toString() == 'Basketball 2 (Main Sports Stadium)' ||
            _chosenValue.toString() == 'Basketball 2 (Main Sports Stadium)') &&
        (_chosenValue2.toString() == '03.00-03.50 PM' ||
            _chosenValue2.toString() == '04.00-04.50 PM' ||
            _chosenValue2.toString() == '09.30-10.20 AM' ||
            _chosenValue2.toString() == '10.30-11.20 AM' ||
            _chosenValue2.toString() == '11.30-12.20 PM')) {
      Fluttertoast.showToast(
        msg: "This combination for booking is not available.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if ((_chosenValue.toString().contains('Tennis Courts')) &&
        (_chosenValue2.toString() == '03.00-03.50 PM' ||
            _chosenValue2.toString() == '08.30-09.20 AM' ||
            _chosenValue2.toString() == '09.30-10.20 AM' ||
            _chosenValue2.toString() == '10.30-11.20 AM' ||
            _chosenValue2.toString() == '11.30-12.20 PM')) {
      Fluttertoast.showToast(
        msg: "This combination for booking is not available.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      String? userEmail = '';
      var list;
      try {
        final User? user = FirebaseAuth.instance.currentUser;
        setState(() {
          userEmail = user?.email;
        });
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .collection("user bookings")
            .get();
        list = querySnapshot.docs;
      } catch (e) {
        showError(e.toString());
      }

      //check if user already booked same slot or same ground on same day
      if (list != null) {
        for (var res in list) {
          String date = res.data()["date"];
          String ground = res.data()["ground"];
          String time = res.data()["slot"];
          print(date + " " + ground + " " + time);
          // if (date ==
          //         currentDate.day.toString() +
          //             "_" +
          //             currentDate.month.toString() +
          //             "_" +
          //             currentDate.year.toString() &&
          //     ground == chosenValue) {
          //   Fluttertoast.showToast(
          //     msg: "You have already booked this facility on this day",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //   );
          //   return;
          // } else if (time == chosenValue2.toString()) {
          //   Fluttertoast.showToast(
          //     msg: "You have already booked this slot on this day",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //   );
          //   return;
          // }
        }
        try {
          var collection = FirebaseFirestore.instance.collection('bookings');
          var docSnapshot = await collection
              .doc(_chosenValue.toString())
              .collection(currentDate.day.toString() +
                  "_" +
                  currentDate.month.toString() +
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
  }

  getDependents() async {
    print("USEREMAIL " + userEmail!);
    var res = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();
    String name = res.data()!['name'];
    // showError(name + " NAME");

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("dependents")
        .doc(userEmail)
        .collection("names")
        .get();
    var list = querySnapshot.docs;
    setState(() {
      // depList = list;
      depList.add(name);
      for (int i = 0; i < list.length; i++) {
        depList.add(list[i].id.toString());
      }
      print("PRINTING");
      for (int i = 0; i < depList.length; i++) {
        print(depList[i]);
        // showError(depList[i]);
      }
    });
  }

  void getInput() async {
    var res = FirebaseAuth.instance.currentUser!;
    userEmail = res.email.toString();
    var res1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();
    setState(() {
      isStudent = (res1.data()!['category'] == 'Student') ? true : false;
    });
  }
}
