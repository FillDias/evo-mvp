import 'package:flutter/material.dart';
import 'package:evo_mvp/models/evento.dart';
import 'package:evo_mvp/pages/detalhes_evento_page.dart';

class EventosPage extends StatefulWidget {
  const EventosPage({super.key});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> with TickerProviderStateMixin {
  late TabController _tabController;

  static final List<Evento> eventos = [
    Evento(
      titulo: 'Vitoria x Desportiva',
      descricao: 'Arena do jacare / Copa capixaba',
      horario: '08 de Julho',
      latitude: -23.55052,
      longitude: -46.633308,
      imagemUrl: 'https://i.imgur.com/BoN9kdC.png',
    ),
    Evento(
      titulo: 'Histona',
      descricao: 'Mestre kiko',
      horario: '20:00',
      latitude: -23.559616,
      longitude: -46.658186,
      imagemUrl: 'https://i.imgur.com/7q4W2fj.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Evo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1F1F2E),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Em Destaque'),
            Tab(text: 'Dicas'),
            Tab(text: 'Filtros'),
          ],
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventosTab(context),
          Center(child: Text('Dicas', style: TextStyle(color: Colors.white))),
          Center(child: Text('Favoritos', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _buildEventosTab(BuildContext context) {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetalhesEventoPage(evento: evento)),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  evento.imagemUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    evento.titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}