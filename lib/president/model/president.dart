

class President {
  final int id;
  final String nom;
  final String dateNais;
  final String dateMandat;
  final String description;
  final String imagePath;
  final List<String> photos;
  final String profissao;
  final String partido;
  final String religiao;


  President({
    required this.id,
    required this.nom,
    required this.description,
    required this.imagePath,
    required this.dateMandat,
    required this.dateNais,
    required this.photos,
    required this.profissao,
    required this.partido,
    required this.religiao
});
}