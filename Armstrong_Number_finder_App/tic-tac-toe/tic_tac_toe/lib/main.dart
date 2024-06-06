import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/screens/HomeScreen.dart';
import 'package:tic_tac_toe/screens/LeaderboardScreen.dart';
import 'package:tic_tac_toe/screens/SettingsScreen.dart';
import 'package:tic_tac_toe/screens/SplashScreen.dart';
import 'package:tic_tac_toe/methods/SymbolColorProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SymbolColorProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
