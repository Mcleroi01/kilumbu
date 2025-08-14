class Feriado {
  final String? id;
  final String nome;
  final String data; // YYYY-MM-DD
  final bool dataMovel;
  final String descricao;
  final String origem;
  final List<String> comoSeComemora;
  final bool feriadoNacional;
  final List<String>? regioesEspecificas;
  final String imageUrl;
  final int importanciaCultural; // 1-5
  final bool feriadoReligioso;
  final List<String> eventosEspeciais;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Feriado({
    this.id,
    required this.nome,
    required this.data,
    required this.dataMovel,
    required this.descricao,
    required this.origem,
    required this.comoSeComemora,
    required this.feriadoNacional,
    this.regioesEspecificas,
    required this.imageUrl,
    required this.importanciaCultural,
    required this.feriadoReligioso,
    required this.eventosEspeciais,
    this.createdAt,
    this.updatedAt,
  });

  factory Feriado.fromJson(Map<String, dynamic> data) {
    return Feriado(
      id: data['id'],
      nome: data['nome'] ?? 'Sem nome',
      data: data['data'] ?? '',
      dataMovel: data['dataMovel'] ?? false,
      descricao: data['descricao'] ?? '',
      origem: data['origem'] ?? 'Origem desconhecida',
      comoSeComemora: List<String>.from(data['comoSeComemora'] ?? []),
      feriadoNacional: data['feriadoNacional'] ?? false,
      regioesEspecificas: data['regioesEspecificas'] != null
          ? List<String>.from(data['regioesEspecificas'])
          : null,
      imageUrl: data['imageUrl'] ?? '',
      importanciaCultural: (data['importanciaCultural'] as int?)?.clamp(1, 5) ?? 3,
      feriadoReligioso: data['feriadoReligioso'] ?? false,
      eventosEspeciais: List<String>.from(data['eventosEspeciais'] ?? []),
      createdAt: data['createdAt']?.toDate(),
      updatedAt: data['updatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'data': data,
      'dataMovel': dataMovel,
      'descricao': descricao,
      'origem': origem,
      'comoSeComemora': comoSeComemora,
      'feriadoNacional': feriadoNacional,
      'regioesEspecificas': regioesEspecificas,
      'imageUrl': imageUrl,
      'importanciaCultural': importanciaCultural,
      'feriadoReligioso': feriadoReligioso,
      'eventosEspeciais': eventosEspeciais,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper to get importance as stars
  String get importanceStars {
    return '⭐' * importanciaCultural;
  }

  // Check if feriado is today
  bool get isToday {
    final now = DateTime.now();
    final feriadoDate = DateTime.tryParse(data);
    if (feriadoDate == null) return false;
    return now.year == feriadoDate.year &&
        now.month == feriadoDate.month &&
        now.day == feriadoDate.day;
  }

  // Get next occurrence of this feriado
  DateTime? get nextOccurrence {
    if (dataMovel) return null; // Handle movable dates differently
    
    final now = DateTime.now();
    final feriadoDate = DateTime.tryParse(data);
    if (feriadoDate == null) return null;
    
    var next = DateTime(now.year, feriadoDate.month, feriadoDate.day);
    if (next.isBefore(now)) {
      next = DateTime(now.year + 1, feriadoDate.month, feriadoDate.day);
    }
    return next;
  }
}
