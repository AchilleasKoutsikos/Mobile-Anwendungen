// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Armstrong Number App',
      home: ArmstrongNumberScreen(),
    );
  }
}

class ArmstrongNumberScreen extends StatefulWidget {
  const ArmstrongNumberScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ArmstrongNumberScreenState createState() => _ArmstrongNumberScreenState();
}

class _ArmstrongNumberScreenState extends State<ArmstrongNumberScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = ''; // Variable für das Anzeigeergebnis
  int _nextArmstrong = 0; // Variable für die nächste Armstrong-Zahl
  bool _isRunning = false; // Variable, um zu verfolgen, ob der Algorithmus läuft oder nicht

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Armstrong Number App'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Starting Number:',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40), // Abstand
                  TextField(
                    textAlign: TextAlign.right,
                    autofocus: true,
                    controller: _controller, // Steuerung für die Eingabe
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      labelText: '123', // Platzhaltertext
                    ),
                  ),
                  const SizedBox(height: 20), // Abstand
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _isRunning ? null : _findNextNumber, // Schaltfläche deaktivieren, wenn der Algorithmus läuft
                      child: const Text('Finde nächste Nummer'),
                    ),
                  ),
                  const SizedBox(height: 20), // Abstand
                  Text(
                    _result, // Anzeigeergebnis
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20), // Abstand
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _isRunning ? null : _addNumber, // Schaltfläche deaktivieren, wenn der Algorithmus läuft
                      child: const Text('Füge die Nummer'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  void _findNextNumber() async { // Funktion enthält asynchronen Code
    setState(() { // UI wird aktualisiert
      _isRunning = true; // Setzen des Flags, dass der Algorithmus läuft
    });   

    final int number = int.tryParse(_controller.text) ?? 0; // Eingegebene Zahl abrufen und in int umwandeln
    _nextArmstrong = await findNextNum(number + 1); // Warten bis nächste Armstrong-Zahl zu finden
    _result = 'Die nächste Armstrong-Zahl ist $_nextArmstrong.'; // Ergebnis aktualisieren

    setState(() { // UI wird aktualisiert
      _isRunning = false; // Setzen des Flags, dass der Algorithmus nicht mehr läuft
    });
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  Future<int> findNextNum(int number) async { // Funktion gibt zukünftiges Ergebnis von Typ 'int' und enthält asynchronen Code
    if (isArmstrong(number) == false) { // Überprüfen, ob die Zahl keine Armstrong-Zahl ist
      await Future.delayed(Duration(milliseconds: 100)); // Eine Verzögerung hinzufügen
      return findNextNum(number + 1); // Rekursiver Aufruf, um die nächste Zahl zu finden
    } else {
      return number; // Die Zahl ist eine Armstrong-Zahl, also zurückgeben
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  void _addNumber() {
    setState(() { // UI wird aktualisiert
      _controller.text = _nextArmstrong.toString(); // Die nächste Armstrong-Zahl zum Eingabefeld hinzufügen
    });
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  bool isArmstrong(int number) {
    int originalNumber = number; // Die ursprüngliche Zahl speichern
    int? summe = 0; // Summe initialisieren
    var nummerLeange = "$number".length; // Die Länge der Zahl bestimmen
    String zuString = "$number"; // Zahl in einen String konvertieren

    for (int i = 0; i < nummerLeange; i++) {
      int t = int.parse(zuString[i]); // Jede Ziffer der Zahl erhalten
      summe = pow(t, nummerLeange) + summe! as int?; // Die Summe der Potenzen der Ziffern berechnen
    }

    return summe == originalNumber; // Überprüfen, ob die Summe gleich der ursprünglichen Zahl ist
  }
}
