class Evento {
  final String titulo;
  final String descricao;
  final String horario;
  final double latitude;
  final double longitude;
  final String imagemUrl;

  const Evento({
    required this.titulo,
    required this.descricao,
    required this.horario,
    required this.latitude,
    required this.longitude,
    required this.imagemUrl,
  });
}