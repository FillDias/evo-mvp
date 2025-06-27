class Evento {
  final String titulo;
  final String descricao;
  final String horario;
  final double latitude;
  final double longitude;
  final String imagemUrl;
  final String categoria;
  final String? linkIngresso; // link para compra de ingresso
  final String? atracoes;     // atrações do evento

  const Evento({
    required this.titulo,
    required this.descricao,
    required this.horario,
    required this.latitude,
    required this.longitude,
    required this.imagemUrl,
    required this.categoria,
    this.linkIngresso,
    this.atracoes,
  });
}


