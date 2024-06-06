import 'package:flutter/material.dart';
import 'package:tic_tac_toe/methods/TicTacToeCell.dart';

class TicTacToeBoard extends StatelessWidget {
  final List<List<String>> board;
  final Function(int, int) onCellTap;

  TicTacToeBoard({required this.board, required this.onCellTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 204,
        height: 204,
        child: CustomPaint(
          painter: TicTacToePainter(), // Zeichnet die Linien des Spielfelds
          child: Column(
            children: List.generate(3, (row) {
              return Expanded(
                child: Row(
                  children: List.generate(3, (col) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onCellTap(
                              row, col); // Handhabt das Antippen der Zellen
                        },
                        child: Container(
                          color: Colors
                              .transparent, // Macht den Zellhintergrund transparent
                          child: Center(
                            child: TicTacToeCell(
                                value: board[row]
                                    [col]), // Zeigt den Wert der Zelle an
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class TicTacToePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Farbe der Linien
      ..strokeWidth = 4; // Dicke der Linien

    double thirdWidth = size.width / 3;
    double thirdHeight = size.height / 3;

    // Zeichnet die vertikalen Linien
    for (var i = 1; i < 3; i++) {
      canvas.drawLine(Offset(thirdWidth * i, 0),
          Offset(thirdWidth * i, size.height), paint);
    }

    // Zeichnet die horizontalen Linien
    for (var i = 1; i < 3; i++) {
      canvas.drawLine(Offset(0, thirdHeight * i),
          Offset(size.width, thirdHeight * i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Verhindert das erneute Zeichnen, wenn keine Änderung vorliegt
  }
}
