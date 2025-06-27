import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class DicaDetalhesPage extends StatefulWidget {
  const DicaDetalhesPage({super.key});

  @override
  State<DicaDetalhesPage> createState() => _DicaDetalhesPageState();
}

class _DicaDetalhesPageState extends State<DicaDetalhesPage> {
  final LatLng localizacao = const LatLng(-20.334221, -40.294362);
  bool _mostrarBola = false;

  void _abrirInstagram() async {
    final url = Uri.parse('https://www.instagram.com/prefiroalcides/');
    if (await canLaunchUrl(url)) {
      setState(() => _mostrarBola = true); // animação da bola ⚽
      await Future.delayed(const Duration(milliseconds: 1000));
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF6FA),
      appBar: AppBar(
        title: const Text('Alcides 🇦🇷'),
        backgroundColor: const Color(0xFF5DB1DE),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildLetreiroAnimado(),
              const SizedBox(height: 16),
              _buildCarrosselImagens(),
              const SizedBox(height: 20),
              _buildDescricao(),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _abrirInstagram,
                icon: const Icon(Icons.link),
                label: const Text('Ver no Instagram'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5DB1DE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          // ⚽ Bola animada
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            right: _mostrarBola ? -80 : MediaQuery.of(context).size.width,
            top: 80,
            child: Image.network(
              'https://i.imgur.com/kfQdG0z.png', // imagem de bola
              width: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetreiroAnimado() {
    return Center(
      child: DefaultTextStyle(
        style: GoogleFonts.pressStart2p(
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.blueAccent,
          ),
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('ALCIDES BURGER 🇦🇷'),
            FlickerAnimatedText('SMASH + EMPANADAS + FUTEBOL ⚽'),
          ],
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildDescricao() {
    const azulArgentina = Color(0xFF5DADE2);
    final corTextoNormal = Colors.grey[800]; // preto claro (cinza escuro)

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🇦🇷⚽ Sobre o Restaurante',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: azulArgentina,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Alcides é mais que uma lanchonete, é uma viagem no tempo direto para os anos 90 — com pôsteres do Batistuta, TV de tubo passando reprises da Copa e um cardápio que joga bonito! Inspirado na mística portenha, o ambiente é descontraído, colorido, e todo decorado com referências ao futebol argentino.',
          style: TextStyle(
            color: corTextoNormal,  // COR DO TEXTO NORMAL ALTERADA AQUI
          ),
        ),
        SizedBox(height: 16),
        Text(
          '🍽️ Principais pratos da casa',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: azulArgentina,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '- 🥟 Empanada de Carne com Requeijão\n'
              '- 🍔 Desgruncho (Burger + linguiça + cheddar)\n'
              '- 🧀 Sarabatuco (2 carnes + linguiça + cheddar)\n'
              '- 🌱 Vegetarianus (Burger de berinjela)',
          style: TextStyle(
            color: corTextoNormal,  // COR DO TEXTO NORMAL ALTERADA AQUI
          ),
        ),
        SizedBox(height: 16),
        Text(
          '📍 Onde fica?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: azulArgentina,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Rua Luiz Fernandes Reis, 269 - Praia da Costa, Vila Velha - ES',
          style: TextStyle(
            color: corTextoNormal,  // COR DO TEXTO NORMAL ALTERADA AQUI
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: localizacao,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('alcides'),
                position: localizacao,
                infoWindow: const InfoWindow(title: 'Alcides 🇦🇷'),
              ),
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          '💸 Média de preços',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: azulArgentina,
          ),
        ),
        Text(
          'De R\$14,99 até R\$92,90',
          style: TextStyle(
            color: corTextoNormal,  // COR DO TEXTO NORMAL ALTERADA AQUI
          ),
        ),
      ],
    );
  }

  Widget _buildCarrosselImagens() {
    final imagens = [
      'https://i.imgur.com/EUoChgM.jpeg',
      'https://i.imgur.com/EvGg00V.jpeg',
      'https://i.imgur.com/lo19jF2.jpeg',
    ];

    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: imagens.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imagens[index]),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}