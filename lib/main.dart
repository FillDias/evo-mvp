import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/eventos_page.dart';

void main() {
  runApp(const RolezandoApp());
}

class RolezandoApp extends StatelessWidget {
  const RolezandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Evo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/eventos': (context) => const EventosPage(),
      },
    );
  }
}
