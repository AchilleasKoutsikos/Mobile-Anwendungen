import 'package:flutter/material.dart';

class SymbolColorProvider extends ChangeNotifier {
  Color _xColor = Colors.blue;
  Color _oColor = Colors.red;

  Color get xColor => _xColor;
  Color get oColor => _oColor;

  void changeXColor(Color color) {
    _xColor = color;
    notifyListeners();
  }

  void changeOColor(Color color) {
    _oColor = color;
    notifyListeners();
  }
}
