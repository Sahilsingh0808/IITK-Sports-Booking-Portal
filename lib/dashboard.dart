import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedCategoryIndex = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? userEmail = "";
  var bookingList = [];

  @override
  initState() {
    super.initState();
    inputData();
    fetch();
    
    print("Bookings " + bookingList.length.toString());
  }

  Future<void> fetch() async {
    bookingList = await fetchBookings();
  }

  void inputData() {
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    // here you write the codes to input the data into firestore
  }

  Future<List> fetchBookings() async {
    inputData();
    var bookingList = [];
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('user bookings');
    userRef.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        bookingList.add(doc.id);
      }
    });
    return bookingList;
  }

  Widget _buildCategoryCard(int index, String title, String count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print(index);
          _selectedCategoryIndex = index;
          print("SAHIL" + index.toString());
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 175.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? const Color(0xFF2950FF)
              : const Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : const BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.blueGrey,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                count,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builderList(
      String heading,
      String desc,
      String id,
      String date,
      String time,
      bool important,
      bool performed,
      bool work,
      bool home,
      bool others,
      String mongoID) {
    {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        padding: const EdgeInsets.all(23.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  heading,
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
              desc,
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
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {
                          // view(heading, desc);
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0029E2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          // edit(heading, desc, id, date, time, important,
                          //     performed, work, home, others, mongoID);
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0029E2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            // deleteData(mongoID);
                          });
                        },
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0029E2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

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
          title: const Text("Your Dashboard"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: ((bookingList.isEmpty == true))
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'No Bookings',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'You have no bookings',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const BookSlot(
                                  title: '',
                                ),
                              ),
                            );
                          },
                          child: Ink(
                              color: Colors.greenAccent,
                              width: 120,
                              height: 70,
                              child: const Center(
                                  child: Text(
                                'Book Slot',
                                textScaleFactor: 2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    Builder(builder: (context) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Your Bookings:",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: Colors.green,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BookSlot(
                              title: '',
                            ),
                          ),
                        );
                      },
                      child: Ink(
                          color: Colors.greenAccent,
                          width: 120,
                          height: 70,
                          child: const Center(
                              child: Text(
                            'Book Slot',
                            textScaleFactor: 2,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
