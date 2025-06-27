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
  final TextEditingController _searchController = TextEditingController();
  String _categoriaSelecionada = 'Todos';

  static final List<Evento> todosEventos = [
    Evento(
      titulo: 'Vitoria x Desportiva',
      descricao: 'Arena do Jacaré / Copa Capixaba',
      horario: '08 de Julho',
      latitude: -23.55052,
      longitude: -46.633308,
      imagemUrl: 'https://i.imgur.com/d3XkRq4.png',
      categoria: 'Esporte',
    ),
    Evento(
      titulo: 'Histona',
      descricao: 'Show do Mestre Kiko',
      horario: '20:00',
      latitude: -23.559616,
      longitude: -46.658186,
      imagemUrl: 'https://i.imgur.com/j1q2VKm.jpeg',
      categoria: 'Música',
    ),
  ];

  List<Evento> eventosFiltrados = List.from(todosEventos);

  final List<String> categorias = ['Todos', 'Esporte', 'Música'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _filtrarEventos(String filtro) {
    setState(() {
      eventosFiltrados = todosEventos
          .where((evento) => evento.titulo.toLowerCase().contains(filtro.toLowerCase()) &&
          (_categoriaSelecionada == 'Todos' || evento.categoria == _categoriaSelecionada))
          .toList();
    });
  }

  void _filtrarPorCategoria(String categoria) {
    setState(() {
      _categoriaSelecionada = categoria;
      _filtrarEventos(_searchController.text);
    });
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
          _buildCarrosselDestaques(context),
          const Center(child: Text('Dicas', style: TextStyle(color: Colors.white))),
          _buildFiltroEventos(),
        ],
      ),
    );
  }

  Widget _buildCarrosselDestaques(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todosEventos.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final evento = todosEventos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetalhesEventoPage(evento: evento)),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.network(
                          evento.imagemUrl,
                          height: 240,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                evento.categoria == 'Esporte'
                                    ? Icons.sports_soccer
                                    : Icons.music_note,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                evento.titulo,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFiltroEventos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar evento...',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF1F1F2E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
            ),
            onChanged: _filtrarEventos,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButton<String>(
            value: _categoriaSelecionada,
            dropdownColor: const Color(0xFF1F1F2E),
            iconEnabledColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            items: categorias.map((cat) {
              return DropdownMenuItem(
                value: cat,
                child: Text(cat),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                _filtrarPorCategoria(value);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: eventosFiltrados.length,
            itemBuilder: (context, index) {
              final evento = eventosFiltrados[index];
              return ListTile(
                title: Text(evento.titulo, style: const TextStyle(color: Colors.white)),
                subtitle: Text(evento.horario, style: const TextStyle(color: Colors.white70)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetalhesEventoPage(evento: evento)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
