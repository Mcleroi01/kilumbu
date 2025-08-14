class HeroiNacional {
  final int id;
  final String nome;
  final String biografia;
  final String imageUrl;
  final String localNascimento;
  final String dataNascimento;
  final String? dataFalecimento;
  final String contexteHistorico;
  final List<String> contribuicoes;
  final List<String> citations;
  final bool reconhecidoOficialmente;
  final String? dataReconhecimento;
  final List<String> hommages;

  HeroiNacional({
    required this.id,
    required this.nome,
    required this.biografia,
    required this.imageUrl,
    required this.localNascimento,
    required this.dataNascimento,
    this.dataFalecimento,
    required this.contexteHistorico,
    required this.contribuicoes,
    required this.citations,
    required this.reconhecidoOficialmente,
    this.dataReconhecimento,
    required this.hommages,
  });

  factory HeroiNacional.fromJson(Map<String, dynamic> json) {
    return HeroiNacional(
      id: int.parse(json['id'].toString()),
      nome: json['nome'],
      biografia: json['biografia'],
      imageUrl: json['imageUrl'],
      localNascimento: json['localNascimento'],
      dataNascimento: json['dataNascimento'],
      dataFalecimento: json['dataFalecimento'],
      contexteHistorico: json['contexteHistorico'],
      contribuicoes: List<String>.from(json['contribuicoes']),
      citations: List<String>.from(json['citations']),
      reconhecidoOficialmente: json['reconhecidoOficialmente'],
      dataReconhecimento: json['dataReconhecimento'],
      hommages: List<String>.from(json['hommages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'biografia': biografia,
      'imageUrl': imageUrl,
      'localNascimento': localNascimento,
      'dataNascimento': dataNascimento,
      'dataFalecimento': dataFalecimento,
      'contexteHistorico': contexteHistorico,
      'contribuicoes': contribuicoes,
      'citations': citations,
      'reconhecidoOficialmente': reconhecidoOficialmente,
      'dataReconhecimento': dataReconhecimento,
      'hommages': hommages,
    };
  }
}
