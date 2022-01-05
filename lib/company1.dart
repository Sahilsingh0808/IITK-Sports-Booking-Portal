import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/profile.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'info.dart';

class SOF1 extends StatefulWidget {
  final String date, ground, time, people;
  final List<String> depList;
  // ignore: use_key_in_widget_constructors
  const SOF1(this.date, this.ground, this.time, this.people, this.depList);

  @override
  _SOF1State createState() => _SOF1State();
}

class _SOF1State extends State<SOF1> {
  List<bool> _isChecked = [];

  // List<String> depList = [];
  String _currText = '';
  String? userEmail = '';
  int? people = 0;
  final User? _auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInput();
    userEmail = FirebaseAuth.instance.currentUser!.email.toString();
    print(" user " + userEmail!);
    print(widget.people.length.toString() + " LENGTH");
    // getDependents();
    _isChecked = List<bool>.filled(widget.depList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> going = [];
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
            actions: [
              Builder(builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Info()));
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
            title: const Text("Tick all those who are coming in this slot"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard())),
            ),
          ),
          // body: Expanded(
          //     child: SizedBox(
          //   height: 300,
          //   width: 300,
          //   child: Column(
          //     children: ['Sahil', 'Khushi']
          //         .map((t) => CheckboxListTile(
          //               title: Text(t),
          //               value: _isChecked,
          //               onChanged: (val) {
          //                 setState(() {
          //                   _isChecked = val!;
          //                   if (val == true) {
          //                     _currText = t;
          //                   }
          //                 });
          //               },
          //             ))
          //         .toList(),
          //   ),
          // ))
          // body: Text(depList[0]),

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
                    child: Container(
                        height: 300, width: 200, child: buildList(context)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      'Press the OK button once and wait for your booking confirmation'),
                  FloatingActionButton(
                      child: const Icon(Icons.done),
                      onPressed: () {
                        int check = 0;
                        for (int i = 0; i < _isChecked.length; i++) {
                          if (_isChecked[i] == true) {
                            check++;
                          }
                        }
                        setState(() {
                          people = check;
                          print("PEOPLE " + people.toString());
                        });
                        if (check == 0) {
                          Fluttertoast.showToast(
                            msg: "Please select at least one people",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity
                                .BOTTOM, // also possible "TOP" and "CENTER"
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        } else {
                          _onDone();
                        }
                      }),
                ]),
              ),
            ),
          ),
        ));
  }

  Widget buildList(BuildContext context) {
    List<String> list = widget.depList;
    print("LENGTH QWERTY " + list.length.toString());
    return ListView.builder(
      itemCount: (list.length),
      itemBuilder: (context, index) {
        return CheckboxListTile(
            title: Text(list[index]),
            value: _isChecked[index],
            onChanged: (val) {
              setState(
                () {
                  _isChecked[index] = val!;
                },
              );
            });
      },
    );
    // return Text(
    //   widget.depList[1],
    // );
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

  void getInput() async {
    var res = FirebaseAuth.instance.currentUser!;
    userEmail = res.email.toString();
    print(widget.depList.length.toString() + "LENGTH");
  }

  Future<void> _onDone() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 7), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            title: Text('Please wait while your booking is being confirmed'),
          );
        });
    var collection = FirebaseFirestore.instance.collection('bookings');
    var docSnapshot = await collection
        .doc(widget.ground)
        .collection(widget.date)
        .doc(widget.time)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      // You can then retrieve the value from the Map like this:
      int seats = data?['seats'];
      // print((seats) - int.parse(people));
      final nameD = _auth!.displayName;
      int temp = seats - (people!);

      if (((seats) - (people!)) >= 1) {
        int a = (seats);
        print("a " + a.toString());
        a = a - (people!);

        // roll1 += "_" + nameD!;
        // if (int.parse(people) > 0) {
        //   for (int i = 0; i < mailTECs.length; i++) {
        //     roll1 += "_" + mailTECs[i].text;
        //     print(mailTECs[i]);
        //   }
        // }
        print(a);
        try {
          var collection = FirebaseFirestore.instance.collection('bookings');
          var docSnapshot = await collection
              .doc(widget.ground)
              .collection(widget.date)
              .doc(widget.time)
              .get();
          if (docSnapshot.exists) {
            Map<String, dynamic>? data = docSnapshot.data();
            seats = data?['seats'];
          }
          String accompanyDetails = "";

          for (int i = 0; i < widget.depList.length; i++) {
            if (_isChecked[i] == true) {
              accompanyDetails += widget.depList[i] + "%";
            }
          }

          await FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection('user bookings')
              .doc('Booking%%' +
                  widget.ground +
                  "%%" +
                  widget.date +
                  "%%" +
                  widget.time)
              .set({
            'ground': widget.ground,
            'date': widget.date,
            'slot': widget.time,
            'emails': userEmail,
            'accompany': (people! - 1).toString(),
            'accompany details': accompanyDetails,
          });

          await FirebaseFirestore.instance
              .collection("bookings")
              .doc(widget.ground)
              .collection(widget.date)
              .doc(widget.time)
              .update({
            'seats': a,
          });

          var res = await FirebaseFirestore.instance
              .collection('users')
              .doc(userEmail)
              .get();
          String userName = res.data()!['name'];

          String name = '';
          for (int i = 0; i < widget.depList.length; i++) {
            if (_isChecked[i] == true) {
              name = name + widget.depList[i] + ", ";
            }
          }

          //email sent to parent user
          final df = DateFormat('dd-MM-yyyy hh:mm a');
          int myvalue =
              (((DateTime.now()).millisecondsSinceEpoch) / 1000).round();
          ;
          print(df.format(DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)));
          String date1 = widget.date.replaceAll('_', '-');
          sendEmail(
              name: userName!,
              time: df
                  .format(DateTime.fromMillisecondsSinceEpoch(myvalue * 1000)),
              date: date1,
              email: userEmail!,
              facility: widget.ground,
              slot: widget.time,
              message:
                  'Your booking has been confirmed. The details are as follows:',
              subject: 'Booking Confirmation for Sports Facilities IITK');

          //email sent to daughter users(s)
          print(people.toString() + " People");
          for (int i = 0; i < (people!); i++) {
            if (_isChecked[i] == true) {
              print("Sending Email to users");
              await FirebaseFirestore.instance
                  .collection("bookings")
                  .doc(widget.ground)
                  .collection(widget.date)
                  .doc(widget.time)
                  .collection('names')
                  .doc(userEmail! + "%" + widget.depList[i])
                  .set({
                'email': userEmail,
                'name': widget.depList[i],
                'dependent': (widget.depList[i] == userName) ? false : true,
              });
            }

            showSuccess('Booking Confirmed');
          }

          // _dialog.hide();

        } catch (e) {
          showError(e.toString());
        }
        // _dialog.hide();
        // showSuccess("Booking Confirmed");
        // _dialog.hide();
      } else {
        // _dialog.hide();
        showError("Enough Seats not available in this slot");
        print("Error");
        return;
      }
    } else {
      print("Snapshot empty");
    }
  }

  showSuccess(String successmessage) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Success',
        desc: successmessage,
        btnOkColor: const Color(0xFF0029E2),
        btnOkOnPress: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        }).show();
  }

  Future sendEmail(
      {required String name,
      required String date,
      required String email,
      required String facility,
      required String slot,
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
            'user_email': email,
            'user_date': date,
            'user_name': name,
            'user_time': time,
            'user_facility': facility,
            'user_slot': slot,
            'user_subject': subject,
            'user_message': message,
            'reply_to': '',
          }
        }));
    // ignore: avoid_print
    print(response.body);
  }
}
