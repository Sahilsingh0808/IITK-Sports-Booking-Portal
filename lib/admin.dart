// ignore_for_file: avoid_print, prefer_const_constructors

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
          title: const Text("Admin Page"),
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
                      refreshSeats();
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

  Future<void> refreshSeats() async {
    DateTime today = DateTime.now();
    for (int i = 2; i < 6; i++) {
      DateTime next = today.add(Duration(days: i));

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

      // String nextDate1 = next1.day.toString() +
      //     '_' +
      //     next1.month.toString() +
      //     '_' +
      //     next1.year.toString();
      print(nextDate);
      _showDialog(
          context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
      await addSeats(nextDate);
      _dialog.hide();
    }
  }

  Future<void> addSeats(date) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('bookings');
    //Basketball 2 Mian Stadium
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 06.30-07.20 AM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 07.30-08.20 AM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 08.30-09.20 AM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 09.30-10.20 AM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 10.30-11.20 AM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 11.30-12.20 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 12.00-12.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 01.00-01.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 02.00-02.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 03.00-03.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 04.00-04.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 05.00-05.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 06.00-06.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 1 (Main Sports Stadium) 07.00-07.50 PM"));
    await users
        .doc('Basketball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 08.00-08.50 PM"));

    //Basketball 2 Mian Stadium
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 06.30-07.20 AM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 07.30-08.20 AM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 08.30-09.20 AM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 09.30-10.20 AM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 10.30-11.20 AM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 11.30-12.20 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 12.00-12.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 01.00-01.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 02.00-02.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 03.00-03.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 04.00-04.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 05.00-05.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 06.00-06.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 07.00-07.50 PM"));
    await users
        .doc('Basketball 2 (Main Sports Stadium)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 2 (Main Sports Stadium) 08.00-08.50 PM"));

    //Basketball 3 Mian Stadium
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 06.30-07.20 AM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 07.30-08.20 AM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 08.30-09.20 AM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 09.30-10.20 AM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 10.30-11.20 AM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 11.30-12.20 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 12.00-12.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 01.00-01.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 02.00-02.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 03.00-03.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 04.00-04.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 05.00-05.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 06.00-06.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 07.00-07.50 PM"));
    await users
        .doc('Basketball 3 (Main Sports Stadium)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Basketball 3 (Main Sports Stadium) 08.00-08.50 PM"));

    //Volleyball 1 (Main Sports Stadium)
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 06.30-07.20 AM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 07.30-08.20 AM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 08.30-09.20 AM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 09.30-10.20 AM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 10.30-11.20 AM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 11.30-12.20 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 12.00-12.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 01.00-01.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 02.00-02.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 03.00-03.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 04.00-04.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 05.00-05.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 06.00-06.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 07.00-07.50 PM"));
    await users
        .doc('Volleyball 1 (Main Sports Stadium)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Main Sports Stadium) 08.00-08.50 PM"));

    // //Gym MWF Old Sports Complex
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.30-07.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 06.30-07.20 AM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.30-08.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 07.30-08.20 AM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.30-09.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 08.30-09.20 AM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 09.30-10.20 AM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('10.30-11.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 10.30-11.20 AM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('11.30-12.20 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 11.30-12.20 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('12.00-12.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 12.00-12.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('01.00-01.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 01.00-01.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('02.00-02.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 02.00-02.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('03.00-03.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 03.00-03.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('04.00-04.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 04.00-04.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('05.00-05.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 05.00-05.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.00-06.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 06.00-06.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.00-07.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 07.00-07.50 PM"));
    // await users
    //     .doc('Gym MWF (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.00-08.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym MWF (Old Sports Complex) 08.00-08.50 PM"));

    // //Gym TTS Old Sports Complex
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.30-07.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 06.30-07.20 AM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.30-08.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 07.30-08.20 AM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.30-09.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 08.30-09.20 AM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 09.30-10.20 AM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('10.30-11.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 10.30-11.20 AM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('11.30-12.20 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 11.30-12.20 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('12.00-12.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 12.00-12.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('01.00-01.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 01.00-01.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('02.00-02.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 02.00-02.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('03.00-03.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 03.00-03.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('04.00-04.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 04.00-04.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('05.00-05.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 05.00-05.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.00-06.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 06.00-06.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.00-07.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 07.00-07.50 PM"));
    // await users
    //     .doc('Gym TTS (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.00-08.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 35,
    // }).then((value) => print("Gym TTS (Old Sports Complex) 08.00-08.50 PM"));

    //Tennis Wall (Old Sports Complex)
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis Wall (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 8,
    }).then((value) =>
            print("Tennis Wall (Old Sports Complex) 08.00-08.50 PM"));

    //Badminton 1 Old Sports Complex
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Badminton 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (Old Sports Complex) 08.00-08.50 PM"));

    //Badminton 2 Old Sports Complex
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Badminton 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (Old Sports Complex) 08.00-08.50 PM"));

    //Squash 1 (Old Sports Complex)
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Squash 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (Old Sports Complex) 08.00-08.50 PM"));

    //Squash 2 (Old Sports Complex)
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Squash 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (Old Sports Complex) 08.00-08.50 PM"));

    //Squash 3 (Old Sports Complex)
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.30-07.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 06.30-07.20 AM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.30-08.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 07.30-08.20 AM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.30-09.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 08.30-09.20 AM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 09.30-10.20 AM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('05.00-05.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 05.00-05.50 PM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('06.00-06.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 06.00-06.50 PM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('07.00-07.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 07.00-07.50 PM"));
    // await users
    //     .doc('Squash 3 (Old Sports Complex)')
    //     .collection(date)
    //     .doc('08.00-08.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 4,
    // }).then((value) => print("Squash 3 (Old Sports Complex) 08.00-08.50 PM"));

    //Volleyball 1 (Old Sports Complex)
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Volleyball 1 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 1 (Old Sports Complex) 08.00-08.50 PM"));

    //Volleyball 2 (Old Sports Complex)
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Volleyball 2 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 2 (Old Sports Complex) 08.00-08.50 PM"));

    //Volleyball 3 (Old Sports Complex)
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Volleyball 3 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 3 (Old Sports Complex) 08.00-08.50 PM"));

    //Volleyball 4 (Old Sports Complex)
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Volleyball 4 (Old Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 16,
    }).then((value) =>
            print("Volleyball 4 (Old Sports Complex) 08.00-08.50 PM"));

    //Badminton 1 (New Sports Complex)
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Badminton 1 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 1 (New Sports Complex) 08.00-08.50 PM"));

    //Badminton 2 (New Sports Complex)
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Badminton 2 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 2 (New Sports Complex) 08.00-08.50 PM"));

    //Badminton 3 (New Sports Complex)
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Badminton 3 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) =>
            print("Badminton 3 (New Sports Complex) 08.00-08.50 PM"));

    //Table Tennis 1 (New Sports Complex)
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 1 (New Sports Complex) 08.00-08.50 PM"));

    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 2 (New Sports Complex) 08.00-08.50 PM"));

    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 3 (New Sports Complex) 08.00-08.50 PM"));

    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 4 (New Sports Complex) 08.00-08.50 PM"));

    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 5 (New Sports Complex) 08.00-08.50 PM"));

    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Table Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) =>
            print("Table Tennis 6 (New Sports Complex) 08.00-08.50 PM"));

    //Squash 1 (New Sports Complex)
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Squash 1 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 1 (New Sports Complex) 08.00-08.50 PM"));

    //Squash 2 (New Sports Complex)
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Squash 2 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Squash 2 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 1 (New Sports Complex)
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 1 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 1 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 2 (New Sports Complex)
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 2 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 2 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 3 (New Sports Complex)
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 3 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 3 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 4 (New Sports Complex)
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 4 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 4 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 5 (New Sports Complex)
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 5 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 5 (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 6 (New Sports Complex)
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 06.30-07.20 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 07.30-08.20 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 08.30-09.20 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 09.30-10.20 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('10.30-11.20 AM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 10.30-11.20 AM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 11.30-12.20 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 12.00-12.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 01.00-01.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 02.00-02.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 03.00-03.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 04.00-04.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 05.00-05.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 06.00-06.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 07.00-07.50 PM"));
    await users
        .doc('Tennis 6 (New Sports Complex)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 4,
    }).then((value) => print("Tennis 6 (New Sports Complex) 08.00-08.50 PM"));

    // //Gym MWF (New Sports Complex)
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('06.30-07.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 06.30-07.20 AM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('07.30-08.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 07.30-08.20 AM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('08.30-09.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 08.30-09.20 AM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 09.30-10.20 AM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('05.00-05.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 05.00-05.50 PM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('06.00-06.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 06.00-06.50 PM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('07.00-07.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 07.00-07.50 PM"));
    // await users
    //     .doc('Gym MWF (New Sports Complex)')
    //     .collection(date)
    //     .doc('08.00-08.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym MWF (New Sports Complex) 08.00-08.50 PM"));

    // //Gym TTS (New Sports Complex)
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('06.30-07.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 06.30-07.20 AM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('07.30-08.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 07.30-08.20 AM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('08.30-09.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 08.30-09.20 AM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 09.30-10.20 AM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('05.00-05.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 05.00-05.50 PM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('06.00-06.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 06.00-06.50 PM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('07.00-07.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 07.00-07.50 PM"));
    // await users
    //     .doc('Gym TTS (New Sports Complex)')
    //     .collection(date)
    //     .doc('08.00-08.50 PM')
    //     .set({
    //   'email': '',
    //   'seats': 20,
    // }).then((value) => print("Gym TTS (New Sports Complex) 08.00-08.50 PM"));

    //Tennis 1 (Tennis Courts)
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 1 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 1 (Tennis Courts) 08.00-08.50 PM"));

    //Tennis 2 (Tennis Courts)
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 2 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 2 (Tennis Courts) 08.00-08.50 PM"));

    //Tennis 3 (Tennis Courts)
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 3 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 3 (Tennis Courts) 08.00-08.50 PM"));

    //Tennis 4 (Tennis Courts)
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 4 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 4 (Tennis Courts) 08.00-08.50 PM"));

    //Tennis 5 (Tennis Courts)
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 5 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 5 (Tennis Courts) 08.00-08.50 PM"));

    //Tennis 6 (Tennis Courts)
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('06.30-07.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 06.30-07.20 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('07.30-08.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 07.30-08.20 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('08.30-09.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 08.30-09.20 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('09.30-10.20 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 09.30-10.20 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('10-11 AM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 10.30-11.20 AM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('11.30-12.20 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 11.30-12.20 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('12.00-12.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 12.00-12.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('01.00-01.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 01.00-01.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('02.00-02.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 02.00-02.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('03.00-03.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 03.00-03.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('04.00-04.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 04.00-04.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('05.00-05.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 05.00-05.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('06.00-06.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 06.00-06.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('07.00-07.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 07.00-07.50 PM"));
    await users
        .doc('Tennis 6 (Tennis Courts)')
        .collection(date)
        .doc('08.00-08.50 PM')
        .set({
      'email': '',
      'seats': 6,
    }).then((value) => print("Tennis 6 (Tennis Courts) 08.00-08.50 PM"));

    // //Pool (Swimming Pool)
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('06.30-07.20 AM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 06.30-07.20 AM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('07.30-08.20 AM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 07.30-08.20 AM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('08.30-09.20 AM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 08.30-09.20 AM"));
    // await users
    //     .doc('Pool (Swimming Pool)')
    //     .collection(date)
    //     .doc('09.30-10.20 AM')
    //     .set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 09.30-10.20 AM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('05.00-05.50 PM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 05.00-05.50 PM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('06.00-06.50 PM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 06.00-06.50 PM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('07.00-07.50 PM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 07.00-07.50 PM"));
    // await users.doc('Pool (Swimming Pool)').collection(date).doc('08.00-08.50 PM').set({
    //   'email': '',
    //   'seats': 30,
    // }).then((value) => print("Pool (Swimming Pool) 08.00-08.50 PM"));
  }
}
