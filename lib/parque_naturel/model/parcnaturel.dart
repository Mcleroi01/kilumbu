class ParcNaturel {
  final int id;
  final String nom;
  final String description;
  final String localisation; // Province ou coordonnées
  final String superficie; // ex: "22 610 km²"
  final String dateCreation; // ex: "1960"
  final List<String> images; // URLs ou assets
  final List<String> especesProtegees; // Liste des espèces emblématiques
  final bool patrimoineUnesco;
  final String climat; // ex: "Tropical sec"
  final String typeVegetation; // ex: "Savane, forêt claire"
  final String activitesDisponibles; // ex: "Safari, randonnée, observation d’oiseaux"
  final String acces; // ex: "Route depuis Luanda, piste 4x4"
  final String conseilsVisite; // ex: "Prévoir anti-moustique, visite entre mai et septembre"
  final String siteWeb; // facultatif, s’il y a un site officiel
  final String imagePrincipale;

  ParcNaturel({
    required this.id,
    required this.nom,
    required this.description,
    required this.localisation,
    required this.superficie,
    required this.dateCreation,
    required this.images,
    required this.especesProtegees,
    required this.patrimoineUnesco,
    required this.climat,
    required this.typeVegetation,
    required this.activitesDisponibles,
    required this.acces,
    required this.conseilsVisite,
    required this.siteWeb,
    required this.imagePrincipale,
  });
}
