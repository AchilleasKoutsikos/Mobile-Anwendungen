import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/methods/SymbolColorProvider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final symbolColorProvider = Provider.of<SymbolColorProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
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
          // Zentrierte Inhalte
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Farbauswahl für 'X'
                _buildColorSelection('X', symbolColorProvider.xColor, symbolColorProvider.changeXColor),
                SizedBox(height: 20),
                // Farbauswahl für 'O'
                _buildColorSelection('O', symbolColorProvider.oColor, symbolColorProvider.changeOColor),
              ],
            ),
          ),
        ],
      ),
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
        currentIndex: 2, // Einstellungen Bildschirm Index
        selectedItemColor: Color.fromARGB(255, 163, 92, 21),
        onTap: (index) {
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
        },
      ),
    );
  }

  // Methode zum Erstellen der Farbauswahl
  Widget _buildColorSelection(String symbol, Color color, void Function(Color) onChanged) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7), // Hintergrundfarbe mit Transparenz
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Symbolanzeige ('X' oder 'O')
              Icon(
                symbol == 'X' ? Icons.close : Icons.panorama_fish_eye,
                color: color,
                size: 50,
              ),
              // Dropdown-Menü zur Farbauswahl
              DropdownButton<Color>(
                value: color,
                onChanged: (Color? newColor) {
                  if (newColor != null) {
                    onChanged(newColor);
                  }
                },
                items: <Color>[Colors.blue, Colors.green, Colors.red, Colors.yellow, Colors.black, Colors.orangeAccent, Colors.purple]
                    .map<DropdownMenuItem<Color>>((Color color) {
                  return DropdownMenuItem<Color>(
                    value: color,
                    child: Container(
                      width: 20,
                      height: 20,
                      color: color,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
