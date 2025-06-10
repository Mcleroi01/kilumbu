class HeroiNacional {
  final int id;
  final String nome;
  final String biografia;
  final String imageUrl;
  final String localNascimento;
  final String dataNascimento;
  final String? dataFalecimento; // Nullable si toujours en vie
  final String contexteHistorico;
  final List<String> contribuicoes;
  final List<String> citations;
  final bool reconhecidoOficialmente; // ← clé pour le filtrage
  final String? dataReconhecimento; // Nullable si non reconnu officiellement
  final List<String> hommages; // statues, rues, musées, jours fériés…

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
}
