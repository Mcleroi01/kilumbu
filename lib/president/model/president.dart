

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


  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: int.parse(json['id'].toString()),
      nom: json['nom'],
      dateNais: json['dateNais'],
      dateMandat: json['dateMandat'],
      description: json['description'],
      imagePath: json['imagePath'],
      photos: List<String>.from(json['photos'] ?? []),
      profissao: json['profissao'],
      partido: json['partido'],
      religiao: json['religiao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'dateNais': dateNais,
      'dateMandat': dateMandat,
      'description': description,
      'imagePath': imagePath,
      'photos': photos,
      'profissao': profissao,
      'partido': partido,
      'religiao': religiao,
    };
  }

}