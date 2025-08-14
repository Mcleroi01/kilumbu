class Province {
  final int id;
  final String nom;
  final String capitale;
  final String superficie;
  final String climat;
  final String description;
  final String imagePath;
  final String mapPath;
  final List<String> photos;
  final String population;

  Province({
    required this.id,
    required this.nom,
    required this.capitale,
    required this.superficie,
    required this.climat,
    required this.description,
    required this.imagePath,
    required this.mapPath,
    required this.photos,
    required this.population,
  });

  factory Province.fromJson(Map<String, dynamic> data) {
    return Province(
      id: int.parse(data['id'].toString()),
      nom: data['nom'] ?? 'Indisponível',
      capitale: data['capitale'] ?? 'Indisponível',
      superficie: data['superficie']?.toString() ?? 'Desconhecida',
      climat: data['climat'] ?? 'Desconhecido',
      description: data['description'] ?? '',
      imagePath: data['imagePath'] ?? '',
      mapPath: data['mapPath'] ?? '',
      photos: List<String>.from(data['photos'] ?? []),
      population: data['population']?.toString() ?? 'Desconhecida',
    );
  }


}
