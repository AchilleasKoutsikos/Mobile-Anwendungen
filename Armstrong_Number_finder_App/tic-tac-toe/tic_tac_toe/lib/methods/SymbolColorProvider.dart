import 'package:flutter/material.dart';

class SymbolColorProvider extends ChangeNotifier {
  Color _xColor = Colors.blue; // Standardfarbe für 'X'
  Color _oColor = Colors.red;  // Standardfarbe für 'O'

  // Getter für die Farbe von 'X'
  Color get xColor => _xColor;
  // Getter für die Farbe von 'O'
  Color get oColor => _oColor;

  // Methode zum Ändern der Farbe von 'X' und Benachrichtigung der Listener
  void changeXColor(Color color) {
    _xColor = color;
    notifyListeners(); // Benachrichtigt alle Listener über die Änderung
  }

  // Methode zum Ändern der Farbe von 'O' und Benachrichtigung der Listener
  void changeOColor(Color color) {
    _oColor = color;
    notifyListeners(); // Benachrichtigt alle Listener über die Änderung
  }
}
