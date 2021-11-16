import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/book.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:gnsdev/profile.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'authentication/registercont.dart';
import 'info.dart';

// class Company extends StatefulWidget {
//   final String date, ground, time, people;
//   const Company(this.date, this.ground, this.time, this.people);

//   @override
//   State<Company> createState() => _CompanyState();
// }

// class _CompanyState extends State<Company> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           child: const Text('Add entries'),
//           onPressed: () async {
//             List<PersonEntry> persons = await Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SOF(),
//               ),
//             );
//             if (persons != null) persons.forEach(print);
//           },
//         ),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
class SOF extends StatefulWidget {
  final String date, ground, time, people;
  // ignore: use_key_in_widget_constructors
  const SOF(this.date, this.ground, this.time, this.people);
  @override
  _SOFState createState() => _SOFState();
}

class _SOFState extends State<SOF> {
  final _formKey = GlobalKey<FormState>();
  var mailTECs = <TextEditingController>[];

  bool _switchValue = false;
  List<bool> isPresent = [];
  List<PersonEntry> entries = [];
  late SimpleFontelicoProgressDialog _dialog;
  final User? _auth = FirebaseAuth.instance.currentUser;
  String? userEmail, phoneUser, rollUser;
  bool? isStudent = false, isStop = false, stafAccompany = false;

  var cards = <Card>[];

  Future sendEmail(
      {required String name,
      required String email,
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
            'user_subject': subject,
            'user_message': message,
            'reply_to': '',
          }
        }));
    // ignore: avoid_print
    print(response.body);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  // static sendRegistrationNotification(String email) async {
  //   Map<String, String> headers = Map();
  //   headers["Authorization"] = "Bearer ";
  //   headers["Content-Type"] = "application/json";

  //   Uri url = 'https://api.sendgrid.com/v3/mail/send' as Uri;
  //   var response = await http.post(url,
  //       headers: headers,
  //       body:
  //           "{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"sahilsingh20@iitk.ac.in\"\n                },\n                {\n                  \"email\": \"\"\n                }\n              ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"sahilsingh08062001@gmail.com\"\n          },\n          \"subject\": \"New user registration\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"New user register: $email\"\n            }\n          ]\n        }");
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });

    var res = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();

    setState(() {
      phoneUser = res.data()!['phone'];
      rollUser = res.data()!['roll'];
      String temp = res.data()!['category'];
      if (temp == 'Student') {
        isStudent = true;
      }
    });
    // here you write the codes to input the data into firestore
  }

  Card createCard() {
    var jobController = TextEditingController();
    mailTECs.add(jobController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
              key: _formKey,
              child: Text('Companion ${cards.length + 1} Email ID')),
          const SizedBox(
            height: 10,
          ),

          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
              controller: jobController,
              decoration: const InputDecoration(labelText: 'IITK E-Mail')),
          // TextFormField(
          //     validator: (text) {
          //       if (text == null || text.isEmpty) {
          //         return 'Text is empty';
          //       }
          //       return null;
          //     },
          //     controller: phoneController,
          //     decoration: const InputDecoration(labelText: 'Mobile Number')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // cards.add(createCard());
    if (int.parse(widget.people) == 0) {
      _onDone();
    }
    inputData();
    print("DATA " + widget.people);
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

  void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
      String text) async {
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);

    if (type == SimpleFontelicoProgressDialogType.custom) {
      _dialog.show(
          message: text,
          type: type,
          width: 150.0,
          height: 75.0,
          loadingIndicator: const Text(
            'C',
            style: TextStyle(fontSize: 24.0),
          ));
    } else {
      _dialog.show(
          message: text,
          type: type,
          horizontal: true,
          width: 150.0,
          height: 75.0,
          hideText: true,
          indicatorColor: Colors.red);
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

  _onDone() {
    if (int.parse(widget.people) > 0) {
      if (_formKey.currentState!.validate()) {
        for (int i = 0; i < cards.length; i++) {
          var mail = mailTECs[i].text;
          if (mail == null || mail.isEmpty) {
            Fluttertoast.showToast(
              msg: 'Please fill all the details',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return;
          }

          entries.add(PersonEntry(mail));
        }
        print("OnDone");
        getSeats(widget.date, widget.ground, widget.people, widget.time);
      }
    } else {
      getSeats(widget.date, widget.ground, widget.people, widget.time);
    }
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
          title: const Text("Fill in your compananions' details"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard())),
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
          child: Column(
            children: <Widget>[
              // const Text('Would you be coming along with your companions?'),
              // const SizedBox(
              //   height: 10,
              // ),
              // CupertinoSwitch(
              //   value: _switchValue,
              //   onChanged: (value) {
              //     setState(() {
              //       _switchValue = value;
              //       stafAccompany = value;
              //       print(stafAccompany);
              //     });
              //   },
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cards[index];
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: const Text('Add New'),
                      onPressed: () => setState(() {
                        if (cards.length < int.parse(widget.people)) {
                          cards.add(createCard());
                        } else {
                          _onDone();
                        }
                      }),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Dashboard()))),
                  ],
                ),
              ),
              const Text(
                  'Press the OK button once and wait for your booking confirmation')
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.done),
            onPressed: () {
              if (cards.length < int.parse(widget.people)) {
                Fluttertoast.showToast(
                  msg: "Please add " +
                      (int.parse(widget.people) - cards.length).toString() +
                      " more entries",
                  toastLength: Toast.LENGTH_LONG,
                  gravity:
                      ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              } else {
                _onDone();
              }
              _onDone;
            }),
      ),
    );
  }

  Future<void> getSeats(
      String date, String ground, String people, String time) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 6), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            title: Text('Please wait while your booking is being confirmed'),
          );
        });
    var seats;
    print("REACHING");
    if (int.parse(widget.people) > 0) {
      setState(() {
        for (int i = 0; i < int.parse(widget.people); i++) {
          isPresent.add(false);
        }
      });
      print("REACHING1");
      final db = FirebaseFirestore.instance;
      var result = await db.collection('users').get();
      for (var res in result.docs) {
        print("RES");
        for (int j = 0; j < mailTECs.length; j++) {
          print("Jack");
          if (mailTECs[j].text == userEmail.toString()) {
            showError('You cannot add yourself here.');
            return;
          }
          if (res.id.toString() == mailTECs[j].text) {
            setState(() {
              isPresent[j] = true;
            });
          }
        }
      }

      for (int i = 0; i < mailTECs.length; i++) {
        if (isPresent[i] == false) {
          showError("User " +
              mailTECs[i].text +
              " is not registered. Please register first to continue.");
          return;
        }
      }
    }

    // _showDialog(
    //     context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');

    var collection = FirebaseFirestore.instance.collection('bookings');
    var docSnapshot = await collection
        .doc(widget.ground)
        .collection(widget.date)
        .doc(widget.time)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      // You can then retrieve the value from the Map like this:
      seats = data?['seats'];
      // print((seats) - int.parse(people));
      final nameD = _auth!.displayName;
      int temp = seats - int.parse(people);
      if (((seats) - int.parse(people)) >= 1) {
        int a = (seats);
        print("a " + a.toString());
        a = a - int.parse(people) - 1;

        print("Peope " + people);
        print("a " + a.toString());
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

            // You can then retrieve the value from the Map like this:
            seats = data?['seats'];
            // emailList = data?['email'];
          }
          // _showDialog(context, SimpleFontelicoProgressDialogType.hurricane,
          //     'Hurricane');

          var res = await FirebaseFirestore.instance
              .collection('users')
              .doc(userEmail)
              .get();
          String userName = '';

          setState(() {
            userName = res.data()!['name'];
          });

          String accompanyDetails = "";
          accompanyDetails += userName + "%";

          print(rollUser! + " Test " + phoneUser!);
          for (int i = 0; i < int.parse(widget.people); i++) {
            var res = await FirebaseFirestore.instance
                .collection('users')
                .doc(mailTECs[i].text)
                .get();
            String name = res.data()!['name'];
            accompanyDetails += name + "%";
          }
          String emails = '';
          emails += userEmail.toString() + '%';
          for (int i = 0; i < int.parse(widget.people); i++) {
            emails += mailTECs[i].text + '%';
            await FirebaseFirestore.instance
                .collection("users")
                .doc(mailTECs[i].text)
                .collection('user bookings')
                .doc('Booking%%' + ground + "%%" + date + "%%" + time)
                .set({
              'ground': ground,
              'date': date,
              'slot': time,
              'accompany': widget.people,
              'emails': emails,
              'accompany details': accompanyDetails,
            });
          }
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection('user bookings')
              .doc('Booking%%' + ground + "%%" + date + "%%" + time)
              .set({
            'ground': ground,
            'date': date,
            'slot': time,
            'accompany': widget.people,
            'emails': emails,
            'accompany details': accompanyDetails,
          });

          // var tempEmail = emailList;
          // for (int i = 0; i < int.parse(widget.people); i++) {
          //   if (mailTECs[i].text == 'D') {
          //     tempEmail += userEmail.toString() + "%";
          //   } else {
          //     tempEmail += mailTECs[i].text + "%";
          //   }
          // }
          // if (stafAccompany = true) {
          //   tempEmail += userEmail;
          //   tempEmail += '%';
          //   print("STAFF ACCOMPANYING");
          // }
          await FirebaseFirestore.instance
              .collection("bookings")
              .doc(widget.ground)
              .collection(widget.date)
              .doc(widget.time)
              .update({
            'seats': a,
          });

          await FirebaseFirestore.instance
              .collection("bookings")
              .doc(widget.ground)
              .collection(widget.date)
              .doc(widget.time)
              .collection('names')
              .doc(userEmail! + '%' + userName)
              .set({
            'email': userEmail,
            'name': userName,
          });

          // for (int i = 0; i < mailTECs.length; i++) {
          //   mails[i] += mailTECs[i].text + "_";
          // }
          // mails[mailTECs.length] = userEmail;

          // final mailer = Mailer(
          //     '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');
          // const toAddress = Address('sahilsingh20@iitk.ac.in');
          // const fromAddress = Address('sahilsingh08062001@gmail.com');
          // final content = Content(
          //     'text/plain',
          //     'Your seat for ' +
          //         widget.ground +
          //         ' on ' +
          //         widget.date +
          //         ' at ' +
          //         widget.time +
          //         ' has been booked.\n');
          // const subject = 'Booking Confirmation for IITK sports facility';
          // const personalization = Personalization([toAddress]);
          // try {
          //   final email = Email([personalization], fromAddress, subject,
          //       content: [content]);
          //   mailer.send(email).then((result) {
          //     // ...
          //   });
          // } catch (e) {
          //   showError("Mail could not be sent");
          // }

          //email sent to parent user
          sendEmail(
              name: 'Games and Sports Council, IITK',
              email: userEmail!,
              message: 'Dear ' +
                  userName +
                  ' (' +
                  userEmail! +
                  ') \nyour seat for ' +
                  widget.ground +
                  ' on ' +
                  widget.date +
                  ' at ' +
                  widget.time +
                  ' has been confirmed.\nRegards\nSPEC Office',
              subject: 'Booking Confirmation for Sports Facilities IITK');

          //email sent to daughter users(s)
          for (int i = 0; i < int.parse(widget.people); i++) {
            print("Sending Email to users");
            print(mailTECs[i].text);
            var res = await FirebaseFirestore.instance
                .collection('users')
                .doc(mailTECs[i].text)
                .get();
            String tempName = res.data()!['name'];
            await FirebaseFirestore.instance
                .collection("bookings")
                .doc(widget.ground)
                .collection(widget.date)
                .doc(widget.time)
                .collection('names')
                .doc(mailTECs[i].text + '%' + tempName)
                .set({
              'email': mailTECs[i].text,
              'name': tempName,
            });

            sendEmail(
                name: 'Games and Sports Council, IITK',
                email: mailTECs[i].text,
                message: 'Dear ' +
                    tempName +
                    ' (' +
                    mailTECs[i].text +
                    ') \nyour seat for ' +
                    widget.ground +
                    ' on ' +
                    widget.date +
                    ' at ' +
                    widget.time +
                    ' has been confirmed by ' +
                    userName +
                    ' (' +
                    userEmail! +
                    ').\nRegards\nSPEC Office',
                subject: 'Booking Confirmation for Sports Facilities IITK');
          }

          showSuccess('Booking Confirmed');

          //
        } catch (e) {
          showError(e.toString());
        }

        // showSuccess("Booking Confirmed");
        //
      } else {
        showError("Enough Seats not available in this slot");
        print("Error");
        return;
      }
    } else {
      print("Snapshot empty");
    }

    //   await FirebaseFirestore.instance
    //       .doc("bookings/Football Main Ground/21_10_2021/6-7 AM")
    //       .get()
    //       .then((<Map<String, dynamic>> snapshot) async {
    //     if (snapshot.exists) {

    //       final rollNo = _auth!.uid;
    //       String key = date + "_" + time;
    //       data = snapshot.data as Map?;
    //       seats = data!['seats'];
    //       String roll1 = data!['Roll No'];
    //       print(value);

    //       if ((int.parse(seats) - int.parse(people)) > 1) {
    //         int a = int.parse(seats);
    //         a -= int.parse(people) - 1;
    //         roll1 += "_" + rollNo;
    //         for (int i = 0; i < rollTECs.length; i++) {
    //           roll1 += "_" + rollTECs[i].toString();
    //         }
    //         try {
    //           await FirebaseFirestore.instance
    //               .collection("bookings")
    //               .doc(ground)
    //               .collection(date)
    //               .doc(time)
    //               .update({'seats': a, 'Roll No': roll1});
    //         } catch (e) {
    //           showError(e.toString());
    //         }
    //       } else {
    //         showError("Enough Seats not available in this slot");
    //       }
    //     } else {
    //       print("Snapshot empty");
    //     }
    //   });
    // } catch (e) {
    //   showError(e.toString());
    // }
  }

  // showAlertDialog(BuildContext context) {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: Text("No"),
  //     onPressed: () {
  //       setState(() {
  //         stafAccompany = false;
  //       });
  //     },
  //   );
  //   Widget continueButton = TextButton(
  //     child: Text("Yes"),
  //     onPressed: () {
  //       setState(() {
  //         stafAccompany = true;
  //       });
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("AlertDialog"),
  //     content: Text("Would you be coming along with your companions?"),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}

class PersonEntry {
  final String mail;

  PersonEntry(this.mail);
  @override
  String toString() {
    return 'Person: mail= $mail';
  }
}
