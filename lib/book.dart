import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'company.dart';

class BookSlot extends StatefulWidget {
  static final navKey = GlobalKey<NavigatorState>();
  const BookSlot({Key? key, required String title}) : super(key: key);

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  DateTime currentDate = DateTime.now();
  late SimpleFontelicoProgressDialog _dialog;
  DateTime currentDate1 = DateTime.now();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');
  String? data1, temp = "Confirm Seat";
  int? seats;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  String? _chosenValue, _chosenValue2, valueText;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(
        bottomNavigationBar: const BottomAppBar(
          color: Colors.blueAccent,
          child: SizedBox(
            height: 26,
            child: Text(
              'Developed by Sahil Singh',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  decorationStyle: TextDecorationStyle.wavy,
                  fontStyle: FontStyle.italic),
            ),
          ),
          elevation: 5,
        ),
        appBar: AppBar(
          title: const Text("Book your seat"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                      'Football Main Ground',
                      'Hockey Main Ground',
                      'Squash 1',
                      'Squash 2',
                      'Squash 3',
                      'P.E.',
                      'Cricket Main Ground',
                      'VolleyBall Main Ground',
                      'BasketBall Main Ground',
                      'Badminton Main Ground',
                      'Tennis Main Ground'
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
                    '6-7 AM',
                    '7-8 AM',
                    '8-9 AM',
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
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Number of People you will accompany:"),
                ),
                NumberPicker(
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
                ),
                Text('Selected Number of People: $_currentValue'),
                const SizedBox(
                  height: 50,
                ),
                Builder(builder: (context) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.green,
                    onTap: () {
                      check(_chosenValue, _chosenValue2);
                    },
                    child: Ink(
                        color: Colors.greenAccent,
                        width: 200,
                        height: 50,
                        child: const Center(
                            child: Text(
                          'Check availabilty',
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  );
                }),
                const SizedBox(
                  height: 50,
                ),
                Builder(builder: (context) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.green,
                    onTap: () {
                      validate(_chosenValue, _chosenValue2);
                    },
                    child: Ink(
                        color: Colors.greenAccent,
                        width: 200,
                        height: 50,
                        child: Center(
                            child: Text(
                          temp!,
                          textScaleFactor: 2,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validate(String? chosenValue, String? chosenValue2) async {
    // print(chosenValue);
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
                    currentDate.year.toString() &&
            ground == chosenValue) {
          Fluttertoast.showToast(
            msg: "You have already booked this ground on this day",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return;
        } else if (time == chosenValue2.toString()) {
          Fluttertoast.showToast(
            msg: "You have already booked this slot on this day",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return;
        }
      }

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
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
  }

  Future<void> check(chosenValue, chosenValue2) async {
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
                    currentDate.year.toString() &&
            ground == chosenValue) {
          Fluttertoast.showToast(
            msg: "You have already booked this ground on this day",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return;
        } else if (time == chosenValue2.toString()) {
          Fluttertoast.showToast(
            msg: "You have already booked this slot on this day",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return;
        }
        try {
          var collection = FirebaseFirestore.instance.collection('bookings');
          var docSnapshot = await collection
              .doc('Football Main Ground')
              .collection('21_10_2021')
              .doc('6-7 AM')
              .get();
          if (docSnapshot.exists) {
            Map<String, dynamic>? data = docSnapshot.data();
            // You can then retrieve the value from the Map like this:
            seats = data?['seats'];
            if (seats! < 0) {
              showError("No seats available");
            } else {
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
}
