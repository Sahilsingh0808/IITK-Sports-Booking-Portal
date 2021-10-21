import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  }

  _onDone() {
    if (_formKey.currentState!.validate()) {
      List<PersonEntry> entries = [];
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
      Navigator.pop(context, entries);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
