class Evento {
  final int? id;
  final String titulo;
  final String descricao;
  final String horario;
  final String imagemUrl;
  final String categoria;
  final double latitude;
  final double longitude;
  // final String? linkIngresso;
  // final String? atracoes;

  Evento({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.horario,
    required this.imagemUrl,
    required this.categoria,
    required this.latitude,
    required this.longitude,
    // this.linkIngresso,
    // this.atracoes,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      horario: json['horario'],
      imagemUrl: json['imagemUrl'],
      categoria: json['categoria'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      // linkIngresso: json['linkIngresso'],
      // atracoes: json['atracoes'],
    );
  }
}
