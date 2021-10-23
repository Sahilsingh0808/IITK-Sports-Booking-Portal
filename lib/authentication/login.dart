// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

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
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text("Log in to your account"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
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
                                        hintText: 'Email'),
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
                                      color: Colors.green.withOpacity(0.2),
                                    ),
                                    child:
                                        const Center(child: Text('Sign in'))))
                          ],
                        ))
                  ],
                ))));
  }

  Future<void> signIn(String email, String password) async {
    print(email + password);
    try {
      _showDialog(
          context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
      (await _auth.signInWithEmailAndPassword(
          email: email, password: password));
      _dialog.hide();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } catch (e) {
      _dialog.hide();
      showError(e.toString());
    }
    _dialog.hide();
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
}
