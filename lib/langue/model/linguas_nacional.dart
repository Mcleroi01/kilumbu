class LinguaNacional {
  final int id; // On prend l'ID du document Firestore comme String
  final String nome;
  final String imageUrl;
  final String region;
  final int locutores;
  final String familiaLinguistica;
  final String descricao;
  final bool reconhecidaOficialmente;
  final List<String> dialectos;
  final List<String> usosCulturais;
  final List<String> iniciativasPreservacao;
  final List<String> exemplosFrases;
  final String urlAula;

  LinguaNacional({
    required this.id,
    required this.nome,
    required this.imageUrl,
    required this.region,
    required this.locutores,
    required this.familiaLinguistica,
    required this.descricao,
    required this.reconhecidaOficialmente,
    required this.dialectos,
    required this.usosCulturais,
    required this.iniciativasPreservacao,
    required this.exemplosFrases,
    required this.urlAula,
  });

  /// 🔁 Factory pour lire un document Firestore
  factory LinguaNacional.fromJson(Map<String, dynamic> json, String id) {
    return LinguaNacional(
      id: int.parse(json['id'].toString()),
      nome: json['nome'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      region: json['region'] ?? '',
      locutores: json['locutores'] ?? 0,
      familiaLinguistica: json['familiaLinguistica'] ?? '',
      descricao: json['descricao'] ?? '',
      reconhecidaOficialmente: json['reconhecidaOficialmente'] ?? false,
      dialectos: List<String>.from(json['dialectos'] ?? []),
      usosCulturais: List<String>.from(json['usosCulturais'] ?? []),
      iniciativasPreservacao: List<String>.from(json['iniciativasPreservacao'] ?? []),
      exemplosFrases: List<String>.from(json['exemplosFrases'] ?? []),
      urlAula: json['urlAula'] ?? '',
    );
  }

}
