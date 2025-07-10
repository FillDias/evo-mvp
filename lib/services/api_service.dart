import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/evento.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.137.224:8080'; // Emulador Android
  // Se estiver usando celular físico, troque para seu IP local ex: 192.168.x.x

  static Future<List<Evento>> fetchEventos() async {
    final response = await http.get(Uri.parse('$baseUrl/eventos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Evento.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar eventos');
    }
  }
}