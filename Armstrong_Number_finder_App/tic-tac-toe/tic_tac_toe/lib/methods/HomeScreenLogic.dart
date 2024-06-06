import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HomeScreenLogic {
  TextEditingController playerOneController = TextEditingController();
  TextEditingController playerTwoController = TextEditingController();

  String playerOneName = '';
  String playerTwoName = '';
  bool gameStarted = false;
  bool isPlayerOneTurn = true;
  List<List<String>> board =
      List.generate(3, (_) => List.generate(3, (_) => ''));

  // Aktualisiert die Spielernamen und startet das Spiel, wenn beide Namen eingegeben wurden
  void updatePlayerNames(
      Function setState, Function triggerVibration, BuildContext context) {
    setState(() {
      playerOneName = playerOneController.text;
      playerTwoName = playerTwoController.text;

      if (playerOneName.isEmpty || playerTwoName.isEmpty) {
        triggerVibration();
        showWarningDialog(context);
      } else {
        gameStarted = true;
      }
    });
  }

  // Löst eine Vibration aus, wenn möglich
  Future<void> triggerVibration() async {
    if (await Vibrate.canVibrate) {
      Vibrate.feedback(FeedbackType.warning);
    }
  }

  // Zeigt ein Warnungsdialog an, wenn nicht beide Spielernamen eingegeben wurden
  void showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warnung'),
          content: Text('Beide Spieler müssen einen Namen eingeben!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Behandelt den Zell-Tap und aktualisiert das Board und den Spielstatus
  void handleTap(int row, int col, Function setState, Function checkWinner,
      Function showWinnerDialog, BuildContext context) {
    setState(() {
      if (board[row][col].isEmpty && gameStarted) {
        board[row][col] = isPlayerOneTurn ? 'X' : 'O';
        isPlayerOneTurn = !isPlayerOneTurn;
        String winner = checkWinner();
        if (winner.isNotEmpty) {
          String winningPlayer = board[row][col];
          showWinnerDialog(context, winningPlayer, setState, winner);
        } else if (checkDraw()) {
          showDrawDialog(context, setState);
        }
      }
    });
  }

  // Überprüft, ob ein Spieler gewonnen hat und gibt die Gewinnrichtung zurück
  String checkWinner() {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] &&
          board[row][1] == board[row][2] &&
          board[row][0].isNotEmpty) {
        return 'horizontal';
      }
    }

    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] &&
          board[1][col] == board[2][col] &&
          board[0][col].isNotEmpty) {
        return 'vertical';
      }
    }

    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      return 'diagonal';
    }
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      return 'diagonal';
    }
    return '';
  }

  // Überprüft, ob das Spiel unentschieden ist
  bool checkDraw() {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  // Zeigt ein Dialogfenster an, wenn ein Spieler gewonnen hat
  void showWinnerDialog(
      BuildContext context, String winner, Function setState, String winType) {
    String winnerName = winner == 'X' ? playerOneName : playerTwoName;
    String winMessage;

    switch (winType) {
      case 'horizontal':
        winMessage = '$winnerName hat horizontal gewonnen!';
        break;
      case 'vertical':
        winMessage = '$winnerName hat vertikal gewonnen!';
        break;
      case 'diagonal':
        winMessage = '$winnerName hat diagonal gewonnen!';
        break;
      default:
        winMessage = '$winnerName hat gewonnen!';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spiel Beendet'),
          content: Text(winMessage),
          actions: <Widget>[
            TextButton(
              child: Text('Neues Spiel'),
              onPressed: () {
                setState(() {
                  gameStarted = false;
                  isPlayerOneTurn = true;
                  board = List.generate(3, (_) => List.generate(3, (_) => ''));
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Leaderboard anzeigen'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/leaderboard');
              },
            ),
          ],
        );
      },
    );
  }

  // Zeigt ein Dialogfenster an, wenn das Spiel unentschieden ist
  void showDrawDialog(BuildContext context, Function setState) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unentschieden'),
          content: Text('Das Spiel ist unentschieden!'),
          actions: <Widget>[
            TextButton(
              child: Text('Neues Spiel'),
              onPressed: () {
                setState(() {
                  gameStarted = false;
                  isPlayerOneTurn = true;
                  board = List.generate(3, (_) => List.generate(3, (_) => ''));
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Leaderboard anzeigen'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/leaderboard');
              },
            ),
          ],
        );
      },
    );
  }
}
