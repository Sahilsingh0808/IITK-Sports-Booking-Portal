import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterCont extends StatefulWidget {
  final int people;

  const RegisterCont({Key? key, required this.people}) : super(key: key);

  @override
  _RegisterContState createState() => _RegisterContState();
}

class _RegisterContState extends State<RegisterCont> {
  final _formKey = GlobalKey<FormState>();
  var nameTECs = <TextEditingController>[];
  var rollTECs = <TextEditingController>[];
  var mailTECs = <TextEditingController>[];
  var phoneTECs = <TextEditingController>[];
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<PersonEntry> entries = [];
  late SimpleFontelicoProgressDialog _dialog;
  final User? _auth = FirebaseAuth.instance.currentUser;
  bool moveAhead = true;
  String? userEmail;

  var cards = <Card>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          title: const Text("Fill in your dependents' details (OneTime)"),
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
                      if (cards.length < (widget.people)) {
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
              if (cards.length < (widget.people)) {
                Fluttertoast.showToast(
                  msg: "Please add " +
                      ((widget.people) - cards.length).toString() +
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
            }),
      ),
    );
  }

  void inputData() {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    // here you write the codes to input the data into firestore
  }

  _onDone() async {
    setState(() {
      moveAhead = true;
    });
    if ((widget.people) > 0) {
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
            setState(() {
              moveAhead = false;
            });
            return;
          } else {
            entries.add(PersonEntry(name, roll, mail, phone));
          }
        }
      }
      if (moveAhead == true) {
        inputData();

        for (int i = 0; i < widget.people; i++) {
          await users.doc(entries[i].mail).set({
            'name': entries[i].name,
            'email': entries[i].mail,
            'relation': entries[i].roll,
            'phone': entries[i].phone,
            'category': 'Dependent',
            'independent email': userEmail
          }).then((value) => print("Registered"));
        }
        print("OnDone");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        Fluttertoast.showToast(
          msg: 'Please fill all the details',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          moveAhead = false;
        });
      }
    }
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
                  return 'Name is empty';
                }
                return null;
              },
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Relation with Independent is empty';
                }
                return null;
              },
              controller: ageController,
              decoration: const InputDecoration(
                  labelText: 'Relation with Independent')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Email is empty';
                }
                return null;
              },
              controller: jobController,
              decoration: const InputDecoration(labelText: 'E-Mail')),
          TextFormField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Phone number is empty';
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
