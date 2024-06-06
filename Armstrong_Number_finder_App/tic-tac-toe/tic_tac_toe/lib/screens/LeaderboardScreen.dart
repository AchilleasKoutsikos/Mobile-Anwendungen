import 'package:flutter/material.dart';
import 'package:tic_tac_toe/methods/PlayerRepository.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> _leaderboard = [];
  bool _isLoading = true;

  final PlayerRepository _repository = PlayerRepository(baseUrl: 'https://your-api-url.com'); // Setze hier deine API-URL

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    try {
      List<Map<String, dynamic>> players = await _repository.fetchPlayers();
      setState(() {
        _leaderboard = players;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Leaderboard',
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _leaderboard.length,
                  itemBuilder: (BuildContext context, int index) {
                    final player = _leaderboard[index];
                    return Card(
                      child: ListTile(
                        title: Text('${player['name']}: ${player['wins']} wins'),
                      ),
                    );
                  },
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
        currentIndex: 1, // Leaderboard screen index
        selectedItemColor: Color.fromARGB(255, 163, 92, 21),
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
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
}
