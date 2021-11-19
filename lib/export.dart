// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gnsdev/profile.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class Export extends StatefulWidget {
  const Export({Key? key}) : super(key: key);

  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<Export> {
  DateTime currentDate = DateTime.now();
  DateTime currentDate1 = DateTime.now();
  String? _chosenValue, _chosenValue2, valueText, pickedDate;

  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    DateTime last = currentDate.add(const Duration(days: 2));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021, 11, 10),
        lastDate: last);

    if (picked != null) {
      setState(() {
        currentDate = picked;
        pickedDate = currentDate.day.toString() +
            "_" +
            currentDate.month.toString() +
            "_" +
            currentDate.year.toString();
        _dateController.text = DateFormat.yMd().format(currentDate);
      });
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
          color: Colors.blueAccent,
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
          title: const Text("Export Data"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
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
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Select the date for which you want to export data',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text("Select Date"),
                      );
                    }),
                    SizedBox(height: 50),
                    InkWell(
                        onTap: () {
                          export(pickedDate!);
                          print(pickedDate!);
                          print('Exporting');
                        },
                        child: Container(
                            height: 40.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF0029E2).withOpacity(1),
                            ),
                            child: const Center(
                                child: Text('Export Data',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
  //     String text) async {
  //   _dialog = SimpleFontelicoProgressDialog(
  //       context: context, barrierDimisable: false);

  //   if (type == SimpleFontelicoProgressDialogType.custom) {
  //     _dialog.show(
  //         message: text,
  //         type: type,
  //         width: 150.0,
  //         height: 75.0,
  //         loadingIndicator: const Text(
  //           'C',
  //           style: TextStyle(fontSize: 24.0),
  //         ));
  //   } else {
  //     _dialog.show(
  //         message: text,
  //         type: type,
  //         horizontal: true,
  //         width: 150.0,
  //         height: 75.0,
  //         hideText: true,
  //         indicatorColor: Colors.red);
  //   }
  // }

  Future<void> export(String date) async {
    var facilities = [
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
    ];
    var slots = [
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
    ];
    var list;
    List<dynamic> df = [];
    List<List<dynamic>> df1 = [];
    df.add('Facility');
    df.add('Slot');
    df.add('Name');
    df.add('Email');
    df1.add(df);
    Fluttertoast.showToast(
      msg: "This may take some time.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    for (int i = 0; i < facilities.length; i++) {
      for (int j = 0; j < slots.length; j++) {
        try {
          // _showDialog(context, SimpleFontelicoProgressDialogType.hurricane,
          //     'Hurricane');
          // showDialog(
          //     barrierDismissible: false,
          //     context: context,
          //     builder: (context) {
          //       Future.delayed(const Duration(seconds: 10), () {
          //         Navigator.of(context).pop(true);
          //       });
          //       return const AlertDialog(
          //         title: Text(
          //             'Please wait, this may take some time. The file will be downloaded automatically.'),
          //       );
          //     });

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('bookings')
              .doc(facilities[i])
              .collection(date)
              .doc(slots[j])
              .collection('names')
              .get();
          list = querySnapshot.docs;
          if (list != null) {
            for (var res in list) {
              String name = res.data()["name"];
              String email = res.data()["email"];
              print(facilities[i] + " " + slots[j] + " " + name + " " + email);
              List<dynamic> df = [];
              df.add(facilities[i]);
              df.add(slots[j]);
              df.add(name);
              df.add(email);
              df1.add(df);
            }
          }
        } catch (e) {
          print(e);
        }
      }
    }
    String csv = makeCsv(df1);
    download(csv.codeUnits, downloadName: date + '.csv');
  }

  void download(
    List<int> bytes, {
    required String downloadName,
  }) {
    // Encode our file in base64
    final _base64 = base64Encode(bytes);
    // Create the link with the file
    final anchor =
        AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
          ..target = 'blank';
    // add the name
    if (downloadName != null) {
      anchor.download = downloadName;
    }
    // trigger download
    document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }

  String makeCsv(List<List<dynamic>> df) {
    String csv = const ListToCsvConverter().convert(df);
    return csv;
  }
}
