import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/info.dart';
import 'package:gnsdev/profile.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardStaff extends StatefulWidget {
  final String facility;
  // ignore: use_key_in_widget_constructors
  const DashboardStaff(this.facility);

  @override
  _DashboardStaffState createState() => _DashboardStaffState();
}

class _DashboardStaffState extends State<DashboardStaff> {
  DateTime currentDate = DateTime.now();
  DateTime currentDate1 = DateTime.now();
  String? _chosenValue, _chosenValue2, valueText, userEmail;
  final TextEditingController _dateController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var emailList = [];
  var rollList = [];
  var nameList = [];
  var userDet1 = [];

  @override
  void initState() {
    super.initState();
    inputData();
  }

  void inputData() {
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    // here you write the codes to input the data into firestore
  }

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

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.white60, fontSize: 15.0);
    TextStyle linkStyle = const TextStyle(
        color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          child: SizedBox(
              height: 26,
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
                              launch('https://home.iitk.ac.in/~sahilsingh20/');
                            }),
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
              )),
          elevation: 5,
        ),
        appBar: AppBar(
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Info()));
                  });
            }),
            // SizedBox(width: 20),
            // Builder(builder: (context) {
            //   return IconButton(
            //       icon: Icon(Icons.person),
            //       onPressed: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) => Profile()));
            //       });
            // }),
            SizedBox(width: 50),
          ],
          title: const Text("Staff Dashboard"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                        "${currentDate.day}/${currentDate.month}/${currentDate.year}"),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _chosenValue,
                  //elevation: 5,
                  style: const TextStyle(color: Colors.black),

                  items: <String>[
                    'Basketball 1 (Main Stadium)',
                    'Basketball 2 (Main Stadium)',
                    'Basketball 3 (Main Stadium)',
                    'Gym MWF (Old Sports Complex)',
                    'Gym TTS (Old Sports Complex)',
                    'Badminton 1 (Old Sports Complex)',
                    'Badminton 2 (Old Sports Complex)',
                    'Squash 1 (Old Sports Complex)',
                    'Squash 2 (Old Sports Complex)',
                    'Squash 3 (Old Sports Complex)',
                    'Volleyball 1 (Old Sports Complex)',
                    'Volleyball 2 (Old Sports Complex)',
                    'Volleyball 3 (Old Sports Complex)',
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
                    'Gym MWF (New Sports Complex)',
                    'Gym TTS (New Sports Complex)',
                    'Tennis 1 (Tennis Courts)',
                    'Tennis 2 (Tennis Courts)',
                    'Tennis 3 (Tennis Courts)',
                    'Tennis 4 (Tennis Courts)',
                    'Tennis 5 (Tennis Courts)',
                    'Tennis 6 (Tennis Courts)',
                    'Pool (Swimming Pool)'
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
                  '9-10 AM',
                  '5-6 PM',
                  '6-7 PM',
                  '7-8 PM',
                  '8-9 PM',
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
              InkWell(
                  onTap: () {
                    checkBookings(widget.facility);
                  },
                  child: Container(
                      height: 50.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                      ),
                      child: const Center(child: Text('Check Bookings')))),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: emailList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            _builderList(
                                'Booking ' + (index + 1).toString(),
                                emailList[index],
                                (nameList.isNotEmpty)
                                    ? nameList[index]
                                    : "Loading",
                                (nameList.isNotEmpty)
                                    ? rollList[index]
                                    : "Loading",
                                (nameList.isNotEmpty)
                                    ? nameList[index]
                                    : "Loading",
                                'result[index].id.toString()',
                                'result[index].data()'),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void view(String heading, String desc, String id, String date, String time,
      String important, String accDetails) {
    String desc1 = "";
    List<String> temp = accDetails.split('%');
    for (int i = 0; i < temp.length; i++) {
      print(temp[i] + "__");
    }
    if (int.parse(id) == 0 || accDetails == "") {
      desc1 = "Not Available";
    } else {
      for (int i = 0; i < temp.length; i++) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (regex.hasMatch(temp[i])) {
          desc1 += temp[i] + "; ";
        }
      }
      // for (int i = 0; i < temp.length; i += 4) {
      //   if (i >= temp.length) {
      //     break;
      //   }
      //   desc1 += temp[i] + "(" + temp[i + 1] + ") ; ";
      // }
    }

    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.NO_HEADER,
      title: 'Accompanied Companions: ' + id,
      desc: 'Details of companions: ' + desc1,
      btnOkColor: const Color(0xFF0029E2),
      btnOkOnPress: () {
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
    ).show();
  }

  late SimpleFontelicoProgressDialog _dialog;

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

  Widget _builderList(String number, String ground, String accompany,
      String date, String time, String desc, String accDetails) {
    {
      if (number == null || number.isEmpty) number = "Not Available";
      if (ground == null || ground.isEmpty) ground = "Not Available";
      if (accompany == null || accompany.isEmpty) accompany = "Not Available";
      if (date == null || date.isEmpty) date = "Not Available";
      if (time == null || time.isEmpty) time = "Not Available";
      if (desc == null || desc.isEmpty) desc = "Not Available";
      if (accDetails == null || accDetails.isEmpty) {
        accDetails = "Not Available";
      }
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(userEmail)
              .collection("user bookings")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              padding: const EdgeInsets.all(23.0),
              decoration: BoxDecoration(
                color: const Color(0xFFC8DBFF),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        number,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // _timeFormatter.format(notes[0].date),
                        time,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    ground,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        // _dateFormatter.format(notes[0].date),
                        date,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
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

  Future<void> checkBookings(String facility) async {
    if (_chosenValue == null) {
      Fluttertoast.showToast(
        msg: "Please select ground",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    } else if (_chosenValue2 == null) {
      Fluttertoast.showToast(
        msg: "Please select time slot",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    } else {
      var result = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(_chosenValue.toString())
          .collection(currentDate.day.toString() +
              "_" +
              currentDate.month.toString() +
              "_" +
              currentDate.year.toString())
          .doc(_chosenValue2.toString())
          .get();

      String emails = '';

      setState(() {
        emails = result.data()!['email'];
        emailList = emails.split('%');
        print(emailList[0] + " emails");
      });

      if (result == null || result.data() == null || emails.isEmpty) {
        Fluttertoast.showToast(
          msg: "No Bookings to show",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
        showError('No Bookings to show');
      } else {
        for (int i = 0; i < emailList.length; i++) {
          if (emailList[i].toString().length > 5) {
            var userDet = await FirebaseFirestore.instance
                .collection('users')
                .doc(emailList[i])
                .get();
            userDet1.add(userDet.data());
          }
        }
        setState(() {
          for (int i = 0; i < emailList.length; i++) {
            if (emailList[i].toString().length > 5) {
              String name = userDet1[i]['name'];
              String roll = userDet1[i]['roll'];
              if (name.isNotEmpty) {
                nameList.add(name);
                rollList.add(roll);
              }
            }
          }
        });
      }

      // for (int i = 0; i < emailList.length; i++) {
      //   print(emailList[i]);
      //   try {
      //     var userData = await FirebaseFirestore.instance
      //         .collection('users')
      //         .doc(emailList[i].toString())
      //         .get();
      //     String name = userData.data()!['name'];
      //     String roll = userData.data()!['roll'];
      //     print("Reaching here");
      //   } catch (e) {
      //     showError(e.toString());
      //   }
      // }

    }
    return;
  }

  userDetails(email) async {
    var res =
        await FirebaseFirestore.instance.collection('users').doc(email).get();
    String name = res.data()!['name'];
    String roll = res.data()!['roll'];
    return [name, roll];
  }
}
