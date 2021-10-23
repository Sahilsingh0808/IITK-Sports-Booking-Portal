import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnsdev/authentication/registercont.dart';
import 'package:gnsdev/dashboard.dart';
import 'package:numberpicker/numberpicker.dart';

class IndependentNumber extends StatefulWidget {
  const IndependentNumber({Key? key}) : super(key: key);

  @override
  _IndependentNumberState createState() => _IndependentNumberState();
}

class _IndependentNumberState extends State<IndependentNumber> {
  late int _currentValue = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Independent number'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NumberPicker(
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 10,
                  step: 1,
                  haptics: true,
                  onChanged: (value) => setState(() {
                    _currentValue = value;
                  }),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(builder: (context) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.green,
                    onTap: () {
    
                      
                      if (_currentValue == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterCont(
                                people: _currentValue,
                              ),
                            ));
                      }
                    },
                    child: Ink(
                        color: Colors.greenAccent,
                        width: 200,
                        height: 50,
                        child: const Center(
                            child: Text(
                          'Next',
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
