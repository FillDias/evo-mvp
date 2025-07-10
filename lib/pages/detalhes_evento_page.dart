import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evo_mvp/models/evento.dart';
// import 'package:url_launcher/url_launcher.dart'; // Comentado por enquanto

class DetalhesEventoPage extends StatefulWidget {
  final Evento evento;
  const DetalhesEventoPage({super.key, required this.evento});

  @override
  State<DetalhesEventoPage> createState() => _DetalhesEventoPageState();
}

class _DetalhesEventoPageState extends State<DetalhesEventoPage> {
  double _avaliacao = 4;

  // void _abrirLinkIngresso() async {
  //   final url = Uri.parse(widget.evento.linkIngresso ?? '');
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Não foi possível abrir o link')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final evento = widget.evento;
    final LatLng posicaoEvento = LatLng(evento.latitude, evento.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(evento.titulo),
        backgroundColor: const Color(0xFF1F1F2E),
      ),
      backgroundColor: const Color(0xFF121212),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Imagem
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              evento.imagemUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Descrição
          Text(
            evento.descricao,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 12),

          // Informações
          Text(
            '🕒 Horário: ${evento.horario}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            '📍 Local: Arena do Evento',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          const Text(
            '🎉 Atrações: Informações em breve',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),

          // Botão (desativado por enquanto)
          // ElevatedButton.icon(
          //   onPressed: null,
          //   icon: const Icon(Icons.confirmation_num),
          //   label: const Text('Comprar Ingresso'),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blueAccent,
          //     foregroundColor: Colors.white,
          //     padding: const EdgeInsets.symmetric(vertical: 14),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),

          // Avaliação
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Avaliação do Evento', style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 6),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _avaliacao ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        _avaliacao = index + 1;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Mapa
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 250,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: posicaoEvento,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('evento'),
                    position: posicaoEvento,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}