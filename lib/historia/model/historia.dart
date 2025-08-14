class Historia {
  final String? id;
  final String titulo;
  final String? subtitulo;
  final String conteudo;
  final String periodoHistorico;
  final String dataInicio;
  final String? dataFim;
  final String localizacao;
  final List<String> personagensImportantes;
  final List<String> fontes;
  final String imageUrl;
  final List<String> galeria;
  final List<String> referencias;
  final String relevanciaAtual;
  final List<String> tags;

  Historia({
    this.id,
    required this.titulo,
    this.subtitulo,
    required this.conteudo,
    required this.periodoHistorico,
    required this.dataInicio,
    this.dataFim,
    required this.localizacao,
    required this.personagensImportantes,
    required this.fontes,
    required this.imageUrl,
    required this.galeria,
    required this.referencias,
    required this.relevanciaAtual,
    required this.tags,
  });

  factory Historia.fromJson(Map<String, dynamic> data) {
    return Historia(
      id: data['id'],
      titulo: data['titulo'] ?? 'Sem título',
      subtitulo: data['subtitulo'],
      conteudo: data['conteudo'] ?? '',
      periodoHistorico: data['periodoHistorico'] ?? 'Período não especificado',
      dataInicio: data['dataInicio'] ?? 'Data desconhecida',
      dataFim: data['dataFim'],
      localizacao: data['localizacao'] ?? 'Local não especificado',
      personagensImportantes: List<String>.from(data['personagensImportantes'] ?? []),
      fontes: List<String>.from(data['fontes'] ?? []),
      imageUrl: data['imageUrl'] ?? '',
      galeria: List<String>.from(data['galeria'] ?? []),
      referencias: List<String>.from(data['referencias'] ?? []),
      relevanciaAtual: data['relevanciaAtual'] ?? 'Relevância não especificada',
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'subtitulo': subtitulo,
      'conteudo': conteudo,
      'periodoHistorico': periodoHistorico,
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'localizacao': localizacao,
      'personagensImportantes': personagensImportantes,
      'fontes': fontes,
      'imageUrl': imageUrl,
      'galeria': galeria,
      'referencias': referencias,
      'relevanciaAtual': relevanciaAtual,
      'tags': tags,
    };
  }
}
