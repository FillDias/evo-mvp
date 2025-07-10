import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  List<Evento> todosEventos = [];
  List<Evento> eventosFiltrados = [];
  bool isLoading = true;

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

  final List<String> categorias = ['Todos', 'Esporte', 'Música'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _carregarEventos();
  }

  Future<void> _carregarEventos() async {
    final response = await http.get(Uri.parse('http://192.168.137.224:8080/eventos'));

    if (response.statusCode == 200) {
      print("🟢 Dados recebidos: ${response.body}"); // 👈 Adicione esta linha!
      final List<dynamic> dados = json.decode(response.body);
      setState(() {
        todosEventos = dados.map((e) => Evento.fromJson(e)).toList();
        eventosFiltrados = List.from(todosEventos);
        isLoading = false;
      });
    } else {
      print('Erro ao carregar eventos: ${response.statusCode}');
    }
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
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (eventosFiltrados.isEmpty) {
      return const Center(child: Text("Nenhum evento encontrado."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: eventosFiltrados.length,
      itemBuilder: (context, index) {
        final evento = eventosFiltrados[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                evento.imagemUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              evento.titulo,
              style: const TextStyle(
                color: Color(0xFF0F2A5A),
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              evento.descricao,
              style: const TextStyle(color: Colors.black54),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF0F2A5A)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalhesEventoPage(evento: evento),
                ),
              );
            },
          ),
        );
      },
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
