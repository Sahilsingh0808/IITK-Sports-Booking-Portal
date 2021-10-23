import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        body: Column(
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
    );
  }
}
