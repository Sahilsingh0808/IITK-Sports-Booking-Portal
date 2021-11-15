// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/admin.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:gnsdev/dashboardstaff.dart';
import 'package:gnsdev/remedy.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

void main() async {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password, name, roll, phone;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool showPassword = false;

  final formKey = GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
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

  late SimpleFontelicoProgressDialog _dialog;

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

  String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value) && value != '123456') {
      return 'Enter Valid Email';
    } else {
      return null;
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
            title: const Text("Log in to your account"),
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
                child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              //   image: DecorationImage(
              //       image: NetworkImage(
              //           "https://ak.picdn.net/shutterstock/videos/10042277/thumb/1.jpg"),
              //       fit: BoxFit.cover),
              // ),
              color: Colors.transparent,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 20,
                shadowColor: Colors.white,
                margin: const EdgeInsets.all(20),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  // borderSide:
                  //     const BorderSide(color: Colors.blue, width: 2)
                ),
                color: Colors.transparent,
                child: SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 20.0,
                                        bottom: 5.0),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: 'IITK Email'),
                                        validator: (value) => value!.isEmpty
                                            ? 'Email is required'
                                            : validateEmail(value.trim()),
                                        onChanged: (value) {
                                          email = value;
                                        },
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 20.0,
                                        bottom: 5.0),
                                    child: SizedBox(
                                      height: 50.0,
                                      child: TextFormField(
                                        obscureText: !showPassword,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showPassword = !showPassword;
                                                });
                                              },
                                              icon: Icon(
                                                showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                            ),
                                            hintText: 'Password'),
                                        validator: (value) => value!.isEmpty
                                            ? 'Password is required'
                                            : null,
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                    )),
                                const SizedBox(
                                  height: 50,
                                ),
                                InkWell(
                                    onTap: () {
                                      if (checkFields()) {
                                        signIn(email!, password!);
                                      }
                                    },
                                    child: Container(
                                        height: 40.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0029E2),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'Sign in',
                                          style: TextStyle(color: Colors.white),
                                        )))),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    forgotPassword();
                                  },
                                  child: const Text("Forgot your password?"),
                                ),
                              ],
                            ))
                      ],
                    )),
              ),
            )),
          )),
    );
  }

  Future<void> signIn(String email, String password) async {
    email = email.trim();
    if (email == '123456' && password == '123456') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const DashboardStaff('football')));
    } else if (email == 'admin@iitk.ac.in' && password == 'IITKadmin') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardAdmin()));
    } else {
      try {
        // showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) {
        //       Future.delayed(const Duration(seconds: 1), () {
        //         Navigator.of(context).pop(true);
        //       });
        //       return const AlertDialog(
        //         title: Text('Please wait. This may take some time.'),
        //       );
        //     });
        // _showDialog(
        //     context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
        (await _auth.signInWithEmailAndPassword(
            email: email, password: password));
        // _dialog.hide();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Remedy()));
        // _dialog.hide();
      } catch (e) {
        // _dialog.hide();
        showError(e.toString());
        // _dialog.hide();
      }
      // _dialog.hide();
    }
  }

  validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
  }

  validateRoll(String value) {
    if (value.isEmpty) {
      return 'Roll number is required';
    }
  }

  Future<void> forgotPassword() async {
    if (email == null || email!.isEmpty) {
      showError('Enter your email');
      return;
    } else if (validateEmail(email!) == 'Enter Valid Email' ||
        !email!.contains('@iitk.ac.in')) {
      showError('Enter Valid Email');
      return;
    } else {
      await _auth.sendPasswordResetEmail(email: email.toString());
      showSuccess('Password reset link sent to your email');
    }
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : showError("Some error occured. Try again.");
}
