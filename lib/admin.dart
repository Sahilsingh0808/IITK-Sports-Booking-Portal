import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);
  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
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
          title: const Text("Admin Page"),
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
              const Text(
                  'ONLY use this button when you have to refresh seats in all facilities from fresh'),
              const SizedBox(height: 50),
              InkWell(
                  onTap: () {
                    refreshSeats();
                  },
                  child: Container(
                      height: 50.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                      ),
                      child: const Center(
                          child: Text('Refresh Seats in Database')))),
            ],
          ),
        ),
      ),
    );
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

  Future<void> refreshSeats() async {
    DateTime today = DateTime.now();
       DateTime next = today.add(const Duration(days: 1));

    String date = today.day.toString() +
        "_" +
        today.month.toString() +
        "_" +
        today.year.toString();

    String nextDate = next.day.toString() +
        '_' +
        next.month.toString() +
        '_' +
        next.year.toString();
    print(date);
    _showDialog(
        context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
    await addSeats(date);
    await addSeats(nextDate);
    _dialog.hide();
  }

  Future<void> addSeats(date) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookings');

    //Basketball 2 Mian Stadium
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 6-7 AM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 7-8 AM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 8-9 AM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 9-10 AM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 5-6 PM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 6-7 PM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 1 (Main Stadium) 7-8 PM"));
    await users
        .doc('Basketball 1 (Main Stadium)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 8-9 PM"));

    //Basketball 2 Mian Stadium
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 6-7 AM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 7-8 AM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 8-9 AM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 9-10 AM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 5-6 PM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 6-7 PM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 7-8 PM"));
    await users
        .doc('Basketball 2 (Main Stadium)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 2 (Main Stadium) 8-9 PM"));

    //Basketball 3 Mian Stadium
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 6-7 AM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 7-8 AM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 8-9 AM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 9-10 AM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 5-6 PM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 6-7 PM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 7-8 PM"));
    await users
        .doc('Basketball 3 (Main Stadium)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Basketball 3 (Main Stadium) 8-9 PM"));

    //Gym MWF Old Sports Complex
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym MWF (Old Sports Complex) 8-9 PM"));

    //Gym TTS Old Sports Complex
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Gym TTS (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 35,
    }).then((value) => print("Gym TTS (Old Sports Complex) 8-9 PM"));

    //Badminton 1 Old Sports Complex
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (Old Sports Complex) 8-9 PM"));

    //Badminton 2 Old Sports Complex
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (Old Sports Complex) 8-9 PM"));

    //Squash 1 (Old Sports Complex)
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 8-9 PM"));

    //Squash 2 (Old Sports Complex)
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 8-9 PM"));

    //Squash 3 (Old Sports Complex)
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Squash 3 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 3 (Old Sports Complex) 8-9 PM"));

    //Volleyball 1 (Old Sports Complex)
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 1 (Old Sports Complex) 8-9 PM"));

    //Volleyball 2 (Old Sports Complex)
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 2 (Old Sports Complex) 8-9 PM"));

    //Volleyball 3 (Old Sports Complex)
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 6-7 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 7-8 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 8-9 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 9-10 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 5-6 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 6-7 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 7-8 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) => print("Volleyball 3 (Old Sports Complex) 8-9 PM"));

    //Badminton 1 (New Sports Complex)
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 1 (New Sports Complex) 8-9 PM"));

    //Badminton 2 (New Sports Complex)
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 2 (New Sports Complex) 8-9 PM"));

    //Badminton 3 (New Sports Complex)
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Badminton 3 (New Sports Complex) 8-9 PM"));

    //Squash 1 (New Sports Complex)
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 8-9 PM"));

    //Squash 2 (New Sports Complex)
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 8-9 PM"));

    //Tennis 1 (New Sports Complex)
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 8-9 PM"));

    //Tennis 2 (New Sports Complex)
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 8-9 PM"));

    //Tennis 3 (New Sports Complex)
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 8-9 PM"));

    //Tennis 4 (New Sports Complex)
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 8-9 PM"));

    //Tennis 5 (New Sports Complex)
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 8-9 PM"));

    //Tennis 6 (New Sports Complex)
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 6-7 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 7-8 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 8-9 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 9-10 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 5-6 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 6-7 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 7-8 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 8-9 PM"));

    //Gym MWF (New Sports Complex)
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 6-7 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 7-8 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 8-9 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 9-10 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 5-6 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 6-7 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 7-8 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym MWF (New Sports Complex) 8-9 PM"));

    //Gym TTS (New Sports Complex)
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 6-7 AM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 7-8 AM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 8-9 AM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 9-10 AM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 5-6 PM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 6-7 PM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 7-8 PM"));
    await users
        .doc('Gym TTS (New Sports Complex)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 20,
    }).then((value) => print("Gym TTS (New Sports Complex) 8-9 PM"));

    //Tennis 1 (Tennis Courts)
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 8-9 PM"));

    //Tennis 2 (Tennis Courts)
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 8-9 PM"));

    //Tennis 3 (Tennis Courts)
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 8-9 PM"));

    //Tennis 4 (Tennis Courts)
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 8-9 PM"));

    //Tennis 5 (Tennis Courts)
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 8-9 PM"));

    //Tennis 6 (Tennis Courts)
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('6-7 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 6-7 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('7-8 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 7-8 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('8-9 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 8-9 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 9-10 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('5-6 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 5-6 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('6-7 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 6-7 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('7-8 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 7-8 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('8-9 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 8-9 PM"));

    //Pool (Swimming Pool)
    await users.doc('Pool (Swimming Pool)').collection(date).doc('6-7 AM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 6-7 AM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('7-8 AM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 7-8 AM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('8-9 AM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 8-9 AM"));
    await users
        .doc('Pool (Swimming Pool)')
        .collection(date)
        .doc('9-10 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 9-10 AM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('5-6 PM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 5-6 PM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('6-7 PM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 6-7 PM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('7-8 PM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 7-8 PM"));
    await users.doc('Pool (Swimming Pool)').collection(date).doc('8-9 PM').set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Pool (Swimming Pool) 8-9 PM"));
  }
}
