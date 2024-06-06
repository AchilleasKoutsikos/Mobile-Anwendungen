import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/methods/TicTacToeBoard.dart';
import 'package:tic_tac_toe/methods/HomeScreenLogic.dart';
import 'package:tic_tac_toe/methods/SymbolColorProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenLogic _logic = HomeScreenLogic(); // Instanz der Logikklasse
  int _selectedIndex = 0; // Für die Navigationselemente

  // Funktion zur Navigation bei Tab-Wechsel
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/leaderboard');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/settings');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final symbolColorProvider =
        Provider.of<SymbolColorProvider>(context); // Farben der Symbole

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tic-Tac-Toe',
          style: TextStyle(
            color: Color.fromARGB(255, 123, 139, 131),
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Hintergrundbild
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 163, 92, 21).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _logic.gameStarted ? 'it\'s on' : 'Spielernamen eingeben',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 123, 139, 131),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Eingabefelder für Spielernamen, wenn das Spiel noch nicht gestartet ist
                    if (!_logic.gameStarted) ...[
                      SizedBox(
                        width: 280,
                        child: TextField(
                          controller: _logic.playerOneController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.close,
                                color: symbolColorProvider.xColor),
                            labelText: 'Spieler 1',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Geben Sie den Namen ein',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 58, 65, 37)
                                .withOpacity(0.7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 280,
                        child: TextField(
                          controller: _logic.playerTwoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.panorama_fish_eye,
                                color: symbolColorProvider.oColor),
                            labelText: 'Spieler 2',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: 'Geben Sie den Namen ein',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 58, 65, 37)
                                .withOpacity(0.7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                    // Start-Button, wenn das Spiel noch nicht gestartet ist
                    Visibility(
                      visible: !_logic.gameStarted,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _logic.updatePlayerNames(
                                setState, _logic.triggerVibration, context);
                          });
                        },
                        child: Text('Start'),
                      ),
                    ),
                    // Anzeigen der Spielernamen und des Spielfelds, wenn das Spiel gestartet ist
                    if (_logic.gameStarted) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close,
                              color: symbolColorProvider.xColor, size: 33),
                          SizedBox(width: 10),
                          Text(
                            _logic.playerOneName,
                            style: TextStyle(
                              fontSize: 25,
                              color: symbolColorProvider.xColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.panorama_fish_eye,
                              color: symbolColorProvider.oColor, size: 25),
                          SizedBox(width: 10),
                          Text(
                            _logic.playerTwoName,
                            style: TextStyle(
                              fontSize: 25,
                              color: symbolColorProvider.oColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // TicTacToeBoard Widget
                      TicTacToeBoard(
                        board: _logic.board,
                        onCellTap: (row, col) {
                          _logic.handleTap(
                              row,
                              col,
                              setState,
                              _logic.checkWinner,
                              _logic.showWinnerDialog,
                              context);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // BottomNavigationBar zur Navigation zwischen verschiedenen Seiten
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 163, 92, 21),
        onTap: _onItemTapped,
      ),
    );
  }
}
