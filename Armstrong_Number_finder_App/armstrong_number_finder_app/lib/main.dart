// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Armstrong Number App',
      home: ArmstrongNumberScreen(),
    );
  }
}

class ArmstrongNumberScreen extends StatefulWidget {
  const ArmstrongNumberScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ArmstrongNumberScreenState createState() => _ArmstrongNumberScreenState();
}

class _ArmstrongNumberScreenState extends State {
  final TextEditingController _controller =
      TextEditingController(); // Create a text controller and use it to retrieve the current value of the TextField.
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Armstrong Number App'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 1 : 1,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.left,
                      'Starting Number:'),
                  const SizedBox(height: 40),
                  TextField(
                    textAlign: TextAlign.right,
                    autofocus: true,
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: '123',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 30,
                    height: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          final int number =
                              int.tryParse(_controller.text) ?? 0;
                          if (isArmstrong(number)) {
                            _result = '$number ist eine Armstrong-Zahl.';
                          } else {
                            _result = '$number ist keine Armstrong-Zahl.';
                          }
                        });
                      },
                      child: const Text('Überprüfen'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      style: TextStyle(fontSize: 40.0),
                      textAlign: TextAlign.center,
                      _result),
                  const SizedBox(height: 20),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: 10,
                height: 10,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final int number = int.tryParse(_controller.text) ?? 0;
                      if (isArmstrong(number)) {
                        _result = '$number ist eine Armstrong-Zahl.';
                      } else {
                        _result = '$number ist keine Armstrong-Zahl.';
                      }
                    });
                  },
                  child: const Text('Überprüfen'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool isArmstrong(int number) {
    int originalNumber = number;
    // Initialisierung der Summenvariable
    int? summe = 0;

    // Bestimmen der Länge der eingegebenen Zahl
    var nummerLeange = "$number".length;

    // Konvertieren der eingegebenen Zahl in einen String
    String zuString = "$number";

    // Durchlaufen jeder Ziffer der eingegebenen Zahl
    for (int i = 0; i < nummerLeange; i++) {
      // Konvertieren jeder Ziffer von String zu Integer
      int t = int.parse(zuString[i]);
      // Hinzufügen der Ziffer, die zur Potenz der Anzahl der Ziffern erhöht ist, zur Summe
      summe = pow(t, nummerLeange) + summe! as int?;
    }

    return summe == originalNumber;
  }
}
