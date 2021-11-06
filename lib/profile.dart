import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:gnsdev/main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.dart';
import 'info.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userEmail = '', name = '', roll = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEmail = auth!.email;
    getDetails();
  }

  showSuccess(String successmessage) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Success',
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

  Future<void> forgotPassword() async {
    if (userEmail == null || userEmail!.isEmpty) {
      showError('Some error occured.');
      return;
    } else {
      await _auth.sendPasswordResetEmail(email: userEmail.toString());
      showSuccess('Password reset link sent to your email');
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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Info()));
                  });
            }),
            const SizedBox(width: 50),
          ],
          title: const Text("My Profile"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.postimg.cc/Nf6mKfFD/Untitled-design-5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://i.ibb.co/hRLDpyq/profile.jpg"),
                          fit: BoxFit.cover)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      alignment: const Alignment(0.0, 2.5),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  (name!.isNotEmpty) ? name! : "Loading",
                  style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.blueGrey,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (roll!.isNotEmpty) ? roll! : "Loading",
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "IITK Sports Facilities Booking Portal",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black45,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    elevation: 2.0,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    elevation: 2.0,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                          },
                          child: const Text(
                            "My Bookings",
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    elevation: 2.0,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            logout();
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDetails() async {
    var res = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get();

    setState(() {
      name = res.data()!['name'];
      roll = res.data()!['roll'];
    });
  }

  void logout() {
    setState(() {
      getDetails();
    });
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
        desc: 'Are you sure you want to logout?',
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
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Sports Booking Facilities IITK',
                        )));
          } catch (e) {
            showError(e.toString());
            // _dialog.hide();
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
}
