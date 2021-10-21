import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/book.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

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

  var cards = <Card>[];

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
      roll1 = data?['Roll No'];
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
          // _showDialog(context, SimpleFontelicoProgressDialogType.hurricane,
          //     'Hurricane');
          await FirebaseFirestore.instance
              .collection("bookings")
              .doc('Football Main Ground')
              .collection('21_10_2021')
              .doc('6-7 AM')
              .update({'seats': a});
          // _dialog.hide();
        } catch (e) {
          showError(e.toString());
        }
        // _dialog.hide();
        showSuccess("Booking Confirmed");
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