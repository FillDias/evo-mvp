import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1AE1E), // Fundo dourado
      body: Stack(
        children: [
          // Imagem de ondas com opacidade
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/ondas.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Conteúdo principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo PNG
                  Image.asset(
                    'assets/images/logo.png',
                    width: 160,
                  ),
                  const SizedBox(height: 20),

                  // Título "EVO"
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F2A5A), // Azul escuro elegante
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Texto descritivo
                  const Text(
                    'Seus eventos favoritos em apenas um lugar, com dicas exclusivas e cupons de até 20% para aproveitar o seu role.',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w300, // ExtraLight
                      color: Colors.white, // ou Color(0xFFFAFAFA) para um branco suave
                    ),
                  ),
                  const Spacer(),

                  // Botão "Fique por dentro"
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/eventos');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF208DFF), // azul vibrante
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Fique por dentro'),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}