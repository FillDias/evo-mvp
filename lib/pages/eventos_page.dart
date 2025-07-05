import 'package:flutter/material.dart';
import 'package:evo_mvp/models/evento.dart';
import 'package:evo_mvp/pages/detalhes_evento_page.dart';
import 'package:evo_mvp/models/dica.dart';
import 'package:evo_mvp/pages/dica_detalhes_page.dart';

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

  final List<Dica> dicas = [
    Dica(
      titulo: 'Hamburgueria do Zé',
      descricao: 'Promoção de 2x1 nos smash burgers todo sábado.',
      imagemUrl: 'https://i.imgur.com/kWp2EMJ.jpeg',
      categoria: 'Gastronomia',
      local: 'Praia do Canto',
    ),
    Dica(
      titulo: 'Alcides',
      descricao: 'Lanchonete temática anos 90 com empanadas e burgers irreverentes.',
      imagemUrl: 'https://i.imgur.com/aOUjYn1.jpeg',
      categoria: 'Gastronomia',
      local: 'Praia da Costa',
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
      backgroundColor: const Color(0xFFD1AE1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD1AE1E),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 36,
            ),
            const SizedBox(width: 10),
            const Text(
              'EVO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2A5A),
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Color(0xFF0F2A5A)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF0F2A5A),
          unselectedLabelColor: Colors.black45,
          indicatorColor: Color(0xFF0F2A5A),
          tabs: const [
            Tab(text: 'Em Destaque'),
            Tab(text: 'Dicas'),
            Tab(text: 'Filtros'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCarrosselDestaques(context),
          _buildAbaDicas(),
          _buildFiltroEventos(),
        ],
      ),
    );
  }

  Widget _buildCarrosselDestaques(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Principais eventos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2A5A),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
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
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8A618),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          evento.imagemUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              evento.titulo,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F2A5A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              evento.descricao,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  evento.categoria == 'Esporte'
                                      ? Icons.sports_soccer
                                      : Icons.music_note,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  evento.horario,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'O que tem para hoje',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2A5A),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: todosEventos.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final evento = todosEventos[index];
              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFC8A618),
                  borderRadius: BorderRadius.circular(12),  // border: Border.all(color: Colors.white),
                  border: Border.all(color: Colors.white),   // borda card branca
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        evento.imagemUrl,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        evento.titulo,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F2A5A),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Eventos do momento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2A5A),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...todosEventos.map((evento) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetalhesEventoPage(evento: evento)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC8A618),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      evento.imagemUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evento.titulo,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F2A5A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            evento.descricao,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            evento.horario,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAbaDicas() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: dicas.length,
      itemBuilder: (context, index) {
        final dica = dicas[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Color(0xFFC8A618),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                dica.imagemUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              dica.titulo,
              style: const TextStyle(
                color: Color(0xFF0F2A5A),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  '${dica.categoria} • ${dica.local}',
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  dica.descricao,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black45, fontSize: 13),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF0F2A5A)),
            onTap: () {
              if (dica.titulo == 'Alcides') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DicaDetalhesPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Página ainda não disponível'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildFiltroEventos() {
    return Container();
  }
}