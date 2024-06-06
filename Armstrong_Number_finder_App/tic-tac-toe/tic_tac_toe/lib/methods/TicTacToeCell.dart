import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/methods/SymbolColorProvider.dart';

class TicTacToeCell extends StatelessWidget {
  final String value;

  TicTacToeCell({required this.value});

  @override
  Widget build(BuildContext context) {
    final symbolColorProvider = Provider.of<SymbolColorProvider>(context);

    return Center(
      child: _buildCellContent(value, symbolColorProvider),
    );
  }

  Widget _buildCellContent(String value, SymbolColorProvider symbolColorProvider) {
    final xColor = symbolColorProvider.xColor;
    final oColor = symbolColorProvider.oColor;

    if (value == 'X') {
      return Icon(Icons.close, color: xColor, size: 36);
    } else if (value == 'O') {
      return Icon(Icons.panorama_fish_eye, color: oColor, size: 36);
    }
    return const SizedBox.shrink();
  }
}
