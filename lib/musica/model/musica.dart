class Musica {
  final String? id;
  final String titulo;
  final String artista;
  final String genero;
  final String estilo;
  final int anoLancamento;
  final String duracao;
  final String letra;
  final String? traducao;
  final String contextoHistorico;
  final List<String> instrumentos;
  final String imageUrl;
  final String audioUrl;
  final String? videoUrl;
  final String regiao;
  final List<String> influencias;
  final List<String>? premiacoes;
  final int popularidade;

  Musica({
    this.id,
    required this.titulo,
    required this.artista,
    required this.genero,
    required this.estilo,
    required this.anoLancamento,
    required this.duracao,
    required this.letra,
    this.traducao,
    required this.contextoHistorico,
    required this.instrumentos,
    required this.imageUrl,
    required this.audioUrl,
    this.videoUrl,
    required this.regiao,
    required this.influencias,
    this.premiacoes,
    required this.popularidade,
  });

  factory Musica.fromJson(Map<String, dynamic> data) {
    return Musica(
      id: data['id'],
      titulo: data['titulo'] ?? 'Sem título',
      artista: data['artista'] ?? 'Artista desconhecido',
      genero: data['genero'] ?? 'Gênero desconhecido',
      estilo: data['estilo'] ?? 'Estilo não especificado',
      anoLancamento: data['anoLancamento'] ?? 0,
      duracao: data['duracao'] ?? '00:00',
      letra: data['letra'] ?? '',
      traducao: data['traducao'],
      contextoHistorico: data['contextoHistorico'] ?? '',
      instrumentos: List<String>.from(data['instrumentos'] ?? []),
      imageUrl: data['imageUrl'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
      videoUrl: data['videoUrl'],
      regiao: data['regiao'] ?? 'Região não especificada',
      influencias: List<String>.from(data['influencias'] ?? []),
      premiacoes: data['premiacoes'] != null ? List<String>.from(data['premiacoes']) : null,
      popularidade: data['popularidade'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'artista': artista,
      'genero': genero,
      'estilo': estilo,
      'anoLancamento': anoLancamento,
      'duracao': duracao,
      'letra': letra,
      'traducao': traducao,
      'contextoHistorico': contextoHistorico,
      'instrumentos': instrumentos,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
      'regiao': regiao,
      'influencias': influencias,
      'premiacoes': premiacoes,
      'popularidade': popularidade,
    };
  }
}
