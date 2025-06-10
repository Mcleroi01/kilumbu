class LinguaNacional {
  final int id;
  final String nome; // Nom de la langue (ex: "Kikongo")
  final String imageUrl; // Drapeau, carte, ou illustration
  final String region; // Région(s) principale(s) où la langue est parlée
  final int locutores; // Nombre estimé de locuteurs
  final String familiaLinguistica; // Ex: Bantu, Khoisan, etc.
  final String descricao; // Brève description ou historique
  final bool reconhecidaOficialmente; // Si reconnue comme langue nationale
  final List<String> dialectos; // Variantes régionales
  final List<String> usosCulturais; // Ex: rituels, musique, proverbes…
  final List<String> iniciativasPreservacao; // Actions de sauvegarde ou promotion
  final List<String> exemplosFrases; // Petites phrases ou proverbes dans la langue
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
    required this.urlAula
  });
}
