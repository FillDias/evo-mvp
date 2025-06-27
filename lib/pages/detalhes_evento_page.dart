import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evo_mvp/models/evento.dart' ;

class DetalhesEventoPage extends StatelessWidget {
  final Evento evento;
  const DetalhesEventoPage({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
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
          Image.network(
            evento.imagemUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            evento.descricao,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            'Horário: ${evento.horario}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          SizedBox(
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
        ],
      ),
    );
  }
}
