import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/profile.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import 'book.dart';
import 'info.dart';

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
  var mapData = {};
  var bookedData = [];

  @override
  initState() {
    super.initState();
    inputData();
    fetch();

    print("Bookings " + bookingList.length.toString());
  }

  Future<void> fetch() async {
    await fetchBookings();
  }

  void inputData() {
    final User? user = auth.currentUser;
    setState(() {
      userEmail = user?.email;
    });
    // here you write the codes to input the data into firestore
  }

  fetchBookings() async {
    inputData();
    int i = 0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("user bookings")
        .get();
    var list = querySnapshot.docs;
    print(list[0].id.toString());
    setState(() {
      bookingList = list;
    });
    // for (int i = 0; i < bookingList.length; i++) {
    //   String temp = bookingList[i].id().toString();
    //   print(temp);
    //   List<String> tempList = temp.split("%%");
    //   print("Temp " + tempList[3]);

    //   for (int j = 0; j < temp.length - 1; j++) {
    //     mapData[i][j] = temp[j + 1];
    //     print("Map " + mapData[i][j]);
    //   }
    //   bookedData.add(mapData[i]);
    // }
    print("Length " + list.length.toString());

    // return ListView.builder(
    //   scrollDirection: Axis.vertical,
    //   itemCount: list.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Column(
    //       children: [
    //         _builderList('heading', 'desc', 'id', 'date', 'time', false, false,
    //             false, false, false, 'mongoID')
    //       ],
    //     );
    //   },
    // );

    // final userRef = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userEmail)
    //     .collection('user bookings');
    // await userRef.get().then((snapshot) {
    //   for (var doc in snapshot.docs) {
    //     bookingList.add(doc.id.toString());
    //     i++;
    //     print("DOC ID" + bookingList[i].toString());
    //   }
    // });
  }

  // Widget _buildCategoryCard(int index, String title, String count) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         print(index);
  //         _selectedCategoryIndex = index;
  //         print("SAHIL" + index.toString());
  //       });
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
  //       height: 175.0,
  //       width: 175.0,
  //       decoration: BoxDecoration(
  //         color: _selectedCategoryIndex == index
  //             ? const Color(0xFF2950FF)
  //             : const Color(0xFFF5F7FB),
  //         borderRadius: BorderRadius.circular(20.0),
  //         boxShadow: [
  //           _selectedCategoryIndex == index
  //               ? const BoxShadow(
  //                   color: Colors.black26,
  //                   offset: Offset(0, 2),
  //                   blurRadius: 10.0)
  //               : const BoxShadow(color: Colors.transparent),
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Text(
  //               title,
  //               style: TextStyle(
  //                 color: _selectedCategoryIndex == index
  //                     ? Colors.white
  //                     : Colors.blueGrey,
  //                 fontSize: 28.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Text(
  //               count,
  //               style: TextStyle(
  //                 color: _selectedCategoryIndex == index
  //                     ? Colors.white
  //                     : Colors.black,
  //                 fontSize: 20.0,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _builderList(String number, String ground, String accompany,
      String date, String time, String desc, String accDetails) {
    {
      if (number == null || number.isEmpty) number = "Not Available";
      if (ground == null || ground.isEmpty) ground = "Not Available";
      if (accompany == null || accompany.isEmpty) accompany = "Not Available";
      if (date == null || date.isEmpty) date = "Not Available";
      if (time == null || time.isEmpty) time = "Not Available";
      if (desc == null || desc.isEmpty) desc = "Not Available";
      if (accDetails == null || accDetails.isEmpty)
        accDetails = "Not Available";
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
                      Row(
                        children: [
                          Material(
                            child: InkWell(
                              onTap: () {
                                view(number, ground, accompany, date, time,
                                    desc, accDetails);
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
                          // Material(
                          //   child: InkWell(
                          //     onTap: () {
                          //       // edit(heading, desc, id, date, time, important,
                          //       //     performed, work, home, others, mongoID);
                          //     },
                          //     child: Container(
                          //       height: 30.0,
                          //       width: 30.0,
                          //       decoration: BoxDecoration(
                          //         color: const Color(0xFF0029E2),
                          //         borderRadius: BorderRadius.circular(15.0),
                          //       ),
                          //       child: const Icon(
                          //         Icons.edit,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 15,
                          // ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  deleteData(desc, ground, date, time,
                                      int.parse(accompany));
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
          });
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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Info()));
                  });
            }),
            SizedBox(width: 20),
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  });
            }),
            SizedBox(width: 50),
          ],
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
              : SizedBox(
                  child: Column(
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: bookingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: [
                                    _builderList(
                                        'Booking ' + (index + 1).toString(),
                                        bookingList[index].data()['ground'],
                                        bookingList[index].data()['accompany'],
                                        bookingList[index].data()['date'],
                                        bookingList[index].data()['slot'],
                                        bookingList[index].id.toString(),
                                        bookingList[index]
                                            .data()['accompany details']),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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

  deleteData(String desc, String ground, String date, String slot,
      int accompany) async {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: false,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        closeIcon: const Icon(Icons.close_fullscreen_outlined),
        title: 'Warning',
        btnOkColor: const Color(0xFF0029E2),
        btnCancelColor: const Color(0xFF353B57),
        desc: 'Are you sure you want to delete this booking?',
        btnCancelOnPress: () {},
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
        btnOkOnPress: () async {
          try {
            //  _showDialog(context, SimpleFontelicoProgressDialogType.multiHurricane,
            //       'MultiHurricane');
            //  _showDialog(
            //       context, SimpleFontelicoProgressDialogType.bullets, 'Bullets');
            //  _showDialog(context, SimpleFontelicoProgressDialogType.cog, 'Cog');
            // _showDialog(
            //       context, SimpleFontelicoProgressDialogType.spinner, 'Spinner');
            //  _showDialog(context, SimpleFontelicoProgressDialogType.normal, 'Normal');
            // _showDialog(
            //       context, SimpleFontelicoProgressDialogType.threelines, 'Three Lines');
            //       _showDialog(
            // context, SimpleFontelicoProgressDialogType.multilines, 'Multilines');
            //       _showDialog(
            // context, SimpleFontelicoProgressDialogType.refresh, 'Refresh');
            //                 _showDialog(
            // context, SimpleFontelicoProgressDialogType.phoenix, 'Phoenix');
            // _showDialog(context, SimpleFontelicoProgressDialogType.hurricane,
            //     'Hurricane');
            //  _showDialog(context, SimpleFontelicoProgressDialogType.iphone, 'Iphone');
            var acc = await FirebaseFirestore.instance
                .collection('users')
                .doc(userEmail)
                .collection('user bookings')
                .doc(desc)
                .get();
            String accompany1 = acc.data()!['accompany details'];
            var list = accompany1.split('%');

            FirebaseFirestore.instance
                .collection("users")
                .doc(userEmail)
                .collection("user bookings")
                .doc(desc)
                .delete();

            var collection = FirebaseFirestore.instance.collection('bookings');
            int seats = 0;
            String emailList = '';
            var docSnapshot = await collection
                .doc('Football Main Ground')
                .collection('21_10_2021')
                .doc('6-7 AM')
                .get();
            if (docSnapshot.exists) {
              Map<String, dynamic>? data = docSnapshot.data();
              // You can then retrieve the value from the Map like this:
              seats = data?['seats'];
              emailList = data?['email'];
              emailList.replaceAll(userEmail! + '%', '');
              emailList.replaceAll(userEmail!, '');
              for (int i = 0; i < list.length; i++) {
                emailList.replaceAll(list[i] + '%', '');
                emailList.replaceAll(list[i], '');
              }
            }
            seats += accompany + 1;
            await FirebaseFirestore.instance
                .collection("bookings")
                .doc("Football Main Ground")
                .collection('21_10_2021')
                .doc('6-7 AM')
                .update({'seats': seats, 'email': emailList});

            // _dialog.hide();
            showSuccess('Booking deleted');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ));
          } catch (e) {
            showError(e.toString());
            // _dialog.hide();
            showError(e.toString());
          }
        }).show();
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

  showSuccess(String successmessage) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succes',
        desc: successmessage,
        btnOkColor: const Color(0xFF0029E2),
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        }).show();
  }
}
