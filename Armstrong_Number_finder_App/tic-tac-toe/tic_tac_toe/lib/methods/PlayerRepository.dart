import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerRepository {
  final String baseUrl;

  PlayerRepository({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/players'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((player) => player as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }
}
