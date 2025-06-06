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
}
