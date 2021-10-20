// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/main.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

void main() async {
  runApp(const RegisterPage());
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password, name, roll, phone;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
        body: Center(
            child: SizedBox(
                height: 600.0,
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
                                    decoration:
                                        const InputDecoration(hintText: 'Name'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Name is required'
                                        : validateName(value),
                                    onChanged: (value) {
                                      name = value;
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
                                    decoration: const InputDecoration(
                                        hintText: 'Roll Number'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Roll number is required'
                                        : validateRoll(value),
                                    onChanged: (value) {
                                      roll = value;
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
                                    decoration: const InputDecoration(
                                        hintText: 'Phone Number'),
                                    validator: (value) => value!.isEmpty
                                        ? 'Phone number is required'
                                        : validateRoll(value),
                                    onChanged: (value) {
                                      phone = value;
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
                                    obscureText: true,
                                    decoration: const InputDecoration(
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
                                    signIn(email!, password!, roll!, name!,
                                        phone!);
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

  Future<void> signIn(String email, String password, String roll, String name,
      String phone) async {
    print(email + password + roll + name);
    try {
      _showDialog(
          context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
      (await _auth.createUserWithEmailAndPassword(
          email: email, password: password));

      try {
        print("Registration");
        _showDialog(
            context, SimpleFontelicoProgressDialogType.hurricane, 'Hurricane');
        // await FirebaseFirestore.instance.collection('users').doc(roll).set({
        //   'name': name,
        //   'email': email,
        //   'roll': roll,
        //   'phone': phone,
        //   'password': password
        // });
        await users.doc(roll).set({
          'name': name,
          'email': email,
          'roll': roll,
          'phone': phone,
          'password': password
          // ignore: avoid_print
        }).then((value) => print("Registered"));

        _dialog.hide();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: '',
                    )));
        showSuccess('Account created');
      } catch (e) {
        // ignore: avoid_print
        print("abcdef" + e.toString());
        _dialog.hide();
        showError(e.toString());
      }
      // ignore: unnecessary_null_comparison
      // if (user != null) {
      //   // ignore: deprecated_member_use
      //   await FirebaseAuth.instance.currentUser!.updateProfile(
      //     displayName: name,
      //   );
      // } else {
      //   showError('Something went wrong');
      // }
    } catch (e) {
      _dialog.hide();
      showError(e.toString());
    }
    _dialog.hide();

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const MyHomePage(
    //               title: '',
    //             )));
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
