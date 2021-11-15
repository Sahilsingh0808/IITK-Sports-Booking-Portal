// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardAdminTest extends StatefulWidget {
  const DashboardAdminTest({Key? key}) : super(key: key);
  @override
  _DashboardAdminTestState createState() => _DashboardAdminTestState();
}

class _DashboardAdminTestState extends State<DashboardAdminTest> {
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
          title: const Text("AdminTest Page"),
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
                      // addPaid();
                    },
                    child: Container(
                        height: 50.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF0029E2),
                        ),
                        child: const Center(
                            child: Text('Refresh Seats in Database',
                                style: TextStyle(
                                  color: Colors.white,
                                ))))),
              ],
            ),
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

  addPaid() async {
    final db = FirebaseFirestore.instance;
    var result = await db.collection('users').get();
    for (var res in result.docs) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(res.id.toString())
          .update({'paid': '-1'});
    }
  }

  Future<void> refreshSeats() async {
    DateTime today = DateTime.now();

    String date = today.month.toString() + "_" + today.year.toString();

    // String nextDate1 = next1.day.toString() +
    //     '_' +
    //     next1.month.toString() +
    //     '_' +
    //     next1.year.toString();
    print(date);
    _showDialog(
        context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
    await addSeats(date);
    // await addSeats(nextDate1);
    _dialog.hide();
  }

  Future<void> addSeats(date) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookings');

    //Gym MWF (New Sports Complex)
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Gym MWF (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (New Sports Complex) 08.00-08.50 PM"));

    //Gym TThS (New Sports Complex)
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Gym TThS (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (New Sports Complex) 08.00-08.50 PM"));

    //Gym MWF (Old Sports Complex)
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Gym MWF (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym MWF (Old Sports Complex) 08.00-08.50 PM"));

    //Gym TThS (Old Sports Complex)
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Gym TThS (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 30,
    }).then((value) => print("Gym TThS (Old Sports Complex) 08.00-08.50 PM"));

    //Cardio MWF (Old Sports Complex)
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Cardio MWF (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Cardio MWF (Old Sports Complex) 08.00-08.50 PM"));

    //Cardio TThS (Old Sports Complex)
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Cardio TThS (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Cardio TThS (Old Sports Complex) 08.00-08.50 PM"));
  }
}
