import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HomeScreenLogic {
  TextEditingController playerOneController = TextEditingController();
  TextEditingController playerTwoController = TextEditingController();

  String playerOneName = '';
  String playerTwoName = '';
  bool gameStarted = false;
  bool isPlayerOneTurn = true;
  List<List<String>> board = List.generate(3, (_) => List.generate(3, (_) => ''));

  void updatePlayerNames(Function setState, Function triggerVibration, BuildContext context) {
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

  Future<void> triggerVibration() async {
    if (await Vibrate.canVibrate) {
      Vibrate.feedback(FeedbackType.warning);
    }
  }

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

  void handleTap(int row, int col, Function setState, Function checkWinner, Function showWinnerDialog) {
    setState(() {
      if (board[row][col].isEmpty && gameStarted) {
        board[row][col] = isPlayerOneTurn ? 'X' : 'O';
        isPlayerOneTurn = !isPlayerOneTurn;
        String winner = checkWinner();
        if (winner.isNotEmpty) {
          showWinnerDialog(winner);
        }
      }
    });
  }

  String checkWinner() {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] == board[row][1] && board[row][1] == board[row][2] && board[row][0].isNotEmpty) {
        return board[row][0];
      }
    }

    for (int col = 0; col < 3; col++) {
      if (board[0][col] == board[1][col] && board[1][col] == board[2][col] && board[0][col].isNotEmpty) {
        return board[0][col];
      }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0].isNotEmpty) {
      return board[0][0];
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2].isNotEmpty) {
      return board[0][2];
    }
    return '';
  }

  void showWinnerDialog(BuildContext context, String winner, Function setState) {
  String winnerName = winner == 'X' ? playerOneName : playerTwoName;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Spiel Beendet'),
        content: Text('$winnerName hat gewonnen!'),
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
