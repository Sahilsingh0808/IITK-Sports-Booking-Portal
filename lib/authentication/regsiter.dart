// ignore_for_file: avoid_print

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gnsdev/authentication/independentnumber.dart';
import 'package:gnsdev/authentication/registercont.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:gnsdev/main.dart';
import 'package:email_auth/email_auth.dart';

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
  String? otp, email, password, password1, name, roll, phone, category;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool shouldButtonEnabled = true;

  final formKey = GlobalKey<FormState>();
  late bool submitValid = false, verified = false;
  bool checkbox = false, student = false, showPassword = false;

  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = EmailAuth(
      sessionName: "Sample session",
    );
  }

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

  void sendOtp() async {
    if (email == null || email!.isEmpty) {
      showError("Please enter Email address");
    } else if (!email!.contains('iitk.ac.in')) {
      showError("Please enter your IITK email address");
    } else {
      bool result = await emailAuth.sendOtp(
          recipientMail: email.toString(), otpLength: 8);
      if (result) {
        setState(() {
          submitValid = true;
          showSuccess('OTP sent successfully on ' + email.toString());
        });
      }
    }
  }

  bool verify(String otp) {
    return (emailAuth.validateOtp(
        recipientMail: email.toString(), userOtp: otp.toString()));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Scaffold(
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
                    title: const Text("Create your new account"),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  body: Center(
                      child: SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 500.0,
                        child: Column(
                          children: <Widget>[
                            Form(
                                key: formKey,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: SizedBox(
                                            height: 50.0,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'Name'),
                                              validator: (value) =>
                                                  value!.isEmpty
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
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: SizedBox(
                                            height: 50.0,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'Roll Number'),
                                              validator: (value) => value!
                                                      .isEmpty
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
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Container(
                                            color: submitValid == false
                                                ? Colors.white
                                                : Colors.grey,
                                            height: 50.0,
                                            child: TextFormField(
                                              enabled: !submitValid,
                                              decoration: InputDecoration(
                                                  suffix: GestureDetector(
                                                    child: InkWell(
                                                      child: const Text(
                                                        'Send OTP',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueAccent),
                                                      ),
                                                      onTap: () {
                                                        sendOtp();
                                                        // if (shouldButtonEnabled ==
                                                        //     true) {
                                                        //   sendOtp();
                                                        // } else {
                                                        //   showError(
                                                        //       "Please wait for some time before sending another OTP");
                                                        // }
                                                        setState(() {
                                                          shouldButtonEnabled =
                                                              false;
                                                          Timer(
                                                              const Duration(
                                                                  seconds: 30),
                                                              () =>
                                                                  shouldButtonEnabled =
                                                                      true);
                                                        });

                                                        String? validate =
                                                            validateEmail(email
                                                                .toString());
                                                      },
                                                    ),
                                                  ),
                                                  hintText: 'Email'),
                                              validator: (value) => value!
                                                      .isEmpty
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
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: Container(
                                            color: verified == false
                                                ? Colors.white
                                                : Colors.grey,
                                            height: 50.0,
                                            child: TextFormField(
                                              enabled: !verified,
                                              decoration: InputDecoration(
                                                  suffix: GestureDetector(
                                                    child: InkWell(
                                                        child: const Text(
                                                          'Verify OTP',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                        ),
                                                        onTap: () {
                                                          verify(
                                                              otp.toString());
                                                          if (submitValid ==
                                                              true) {
                                                            bool verifyOTP =
                                                                verify(otp
                                                                    .toString());
                                                            if (verifyOTP ==
                                                                true) {
                                                              showSuccess(
                                                                  "OTP Verified");
                                                              setState(() {
                                                                verified = true;
                                                              });
                                                            } else {
                                                              showError(
                                                                  "OTP not verified");
                                                            }
                                                          } else {
                                                            showError(
                                                                "OTP not yet sent.");
                                                          }
                                                        }),
                                                  ),
                                                  hintText: 'Enter OTP'),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'OTP is required'
                                                      : validateOTP(),
                                              onChanged: (value) {
                                                otp = value;
                                              },
                                            ),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: SizedBox(
                                            height: 50.0,
                                            child: TextFormField(
                                              obscureText: !showPassword,
                                              decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showPassword =
                                                            !showPassword;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      showPassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                    ),
                                                  ),
                                                  hintText: 'Password'),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Password is required'
                                                      : null,
                                              onChanged: (value) {
                                                password = value;
                                              },
                                            ),
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0,
                                              right: 25.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          child: SizedBox(
                                            height: 50.0,
                                            child: TextFormField(
                                              obscureText: !showPassword,
                                              decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        showPassword =
                                                            !showPassword;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      showPassword
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                    ),
                                                  ),
                                                  hintText: 'Confirm Password'),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Password is required'
                                                      : null,
                                              onChanged: (value) {
                                                password1 = value;
                                              },
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DropdownButton<String>(
                                          value: category,
                                          //elevation: 5,
                                          style: const TextStyle(
                                              color: Colors.black),

                                          items: <String>[
                                            'Student',
                                            'Faculty/Staff',
                                            'Project Employee'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: const Text(
                                            "Please choose a category",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onChanged: (value) {
                                            assert(value != null);
                                            setState(() {
                                              category = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(
                                                width: 10,
                                              ), //SizedBox
                                              //Text
                                              const SizedBox(
                                                  width: 10), //SizedBox
                                              /** Checkbox Widget **/
                                              Checkbox(
                                                value: checkbox,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    checkbox = value!;
                                                  });
                                                },
                                              ),
                                              const Text(
                                                'I agree to the terms and conditions',
                                                style:
                                                    TextStyle(fontSize: 14.0),
                                              ), //Checkbox
                                            ], //<Widget>[]
                                          )),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if (checkFields()) {
                                              signIn(email!, password!, roll!,
                                                  name!, phone!);
                                            }
                                          },
                                          child: Container(
                                              height: 40.0,
                                              width: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.2),
                                              ),
                                              child: const Center(
                                                  child: Text('Sign in'))))
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(String email, String password, String roll, String name,
      String phone) async {
    if (checkbox == false) {
      showError("Please agree to the terms and conditions");
      return;
    } else if (password1.toString() != password.toString()) {
      showError("Passwords do not match");
      return;
    } else if (category == null) {
      showError("Please choose a category");
      return;
    }

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
        await users.doc(email).set({
          'name': name,
          'email': email,
          'roll': roll,
          'phone': phone,
          'password': password,
          'category': category.toString()
        }).then((value) => print("Registered"));

        _dialog.hide();
        if (category == 'Student') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const IndependentNumber()));
        }
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

  validateOTP() {
    if (!verified) {
      return 'OTP not verified';
    } else {
      return null;
    }
  }
}
