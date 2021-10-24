import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/book.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;

import 'authentication/registercont.dart';

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
  var nameTECs = <TextEditingController>[];
  var rollTECs = <TextEditingController>[];
  var mailTECs = <TextEditingController>[];
  var phoneTECs = <TextEditingController>[];
  List<PersonEntry> entries = [];
  late SimpleFontelicoProgressDialog _dialog;
  final User? _auth = FirebaseAuth.instance.currentUser;
  String? userEmail;

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
            'reply_to': 'gns.offline@gmail.com',
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

  void inputData() {
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    // here you write the codes to input the data into firestore
  }

  Card createCard() {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var jobController = TextEditingController();
    var phoneController = TextEditingController();
    nameTECs.add(nameController);
    rollTECs.add(ageController);
    mailTECs.add(jobController);
    phoneTECs.add(phoneController);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(key: _formKey, child: Text('Person ${cards.length + 1}')),
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
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Roll Number')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
              controller: jobController,
              decoration: const InputDecoration(labelText: 'E-Mail')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Text is empty';
                }
                return null;
              },
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone No.')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
    if (int.parse(widget.people) == 0) {
      getSeats(widget.date, widget.ground, widget.people, widget.time);
    }
    inputData();
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BookSlot(
                        title: '',
                      )));
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          Navigator.pop(context);
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
          var name = nameTECs[i].text;
          var roll = rollTECs[i].text;
          var mail = mailTECs[i].text;
          var phone = phoneTECs[i].text;
          if (name == null ||
              name.isEmpty ||
              roll == null ||
              roll.isEmpty ||
              mail == null ||
              mail.isEmpty ||
              phone == null ||
              phone.isEmpty) {
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
          entries.add(PersonEntry(name, roll, mail, phone));
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
    return Scaffold(
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
        title: const Text("Fill in your compananions' details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
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
                SizedBox(
                  width: 30,
                ),
                RaisedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          )
        ],
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
    );
  }

  Future<void> getSeats(
      String date, String ground, String people, String time) async {
    var roll1;
    var seats;
    var emailList;

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
      // print((seats) - int.parse(people));
      final nameD = _auth!.displayName;

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
        print(roll1);
        print(a);

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
            emailList = data?['email'];
            print("Email List" + emailList);
          }
          // _showDialog(context, SimpleFontelicoProgressDialogType.hurricane,
          //     'Hurricane');

          String accompanyDetails = "";
          for (int i = 0; i < int.parse(widget.people); i++) {
            accompanyDetails += nameTECs[i].text +
                "%" +
                rollTECs[i].text +
                "%" +
                mailTECs[i].text +
                "%" +
                phoneTECs[i].text +
                "%";
            accompanyDetails += "\n";
          }

          await FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection('user bookings')
              .doc('Booking ' + ground + " " + date + " " + time)
              .set({
            'ground': ground,
            'date': date,
            'slot': time,
            'accompany': widget.people,
            'accompany details': accompanyDetails
          });

          var tempEmail = emailList;
          for (int i = 0; i < int.parse(widget.people); i++) {
            tempEmail += mailTECs[i].text + "%";
          }
          tempEmail += userEmail;
          await FirebaseFirestore.instance
              .collection("bookings")
              .doc("Football Main Ground")
              .collection('21_10_2021')
              .doc('6-7 AM')
              .update({
            'seats': a,
            'email': tempEmail,
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
              message: 'Your seat for ' +
                  widget.ground +
                  ' on ' +
                  widget.date +
                  ' at ' +
                  widget.time +
                  ' has been booked.',
              subject: 'Booking Confirmation for Sports Facilities IITK');

          //email sent to daughter users(s)
          for (int i = 0; i < int.parse(widget.people); i++) {
            print("Sending Email to users");
            print(mailTECs[i].text);
            sendEmail(
                name: 'Games and Sports Council, IITK',
                email: mailTECs[i].text,
                message: userEmail! +
                    'has booked your seat for ' +
                    widget.ground +
                    ' on ' +
                    widget.date +
                    ' at ' +
                    widget.time,
                subject: 'Booking Confirmation for Sports Facilities IITK');
          }

          showSuccess('Booking Confirmed');

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
    // _dialog.hide();

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
}

class PersonEntry {
  final String name;
  final String roll;
  final String mail;
  final String phone;

  PersonEntry(this.name, this.roll, this.mail, this.phone);
  @override
  String toString() {
    return 'Person: name= $name, roll= $roll, mail= $mail, phone= $phone';
  }
}
