import 'package:cloud_firestore_platform_interface/src/timestamp.dart';

class Coordenadas {
  final double latitude;
  final double longitude;

  Coordenadas({required this.latitude, required this.longitude});

  factory Coordenadas.fromJson(Map<String, dynamic> json) {
    return Coordenadas(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Contato {
  final String? telefone;
  final String? email;
  final String? website;

  Contato({this.telefone, this.email, this.website});

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      telefone: json['telefone'],
      email: json['email'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'telefone': telefone,
      'email': email,
      'website': website,
    };
  }
}

class LocalTuristico {
  final String? id;
  final String nome;
  final String tipo; // histórico, natural, cultural, religioso, gastronômico, outro
  final String descricao;
  final Endereco endereco;
  final String horarioFuncionamento;
  final double? precoIngresso;
  final List<String> melhoresEpocas;
  final String comoChegar;
  final Contato contato;
  final String imageUrl;
  final List<String> galeria;
  final List<String> dicasVisita;
  final bool acessibilidade;
  final List<String> tags;
  final double avaliacaoMedia;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocalTuristico({
    this.id,
    required this.nome,
    required this.tipo,
    required this.descricao,
    required this.endereco,
    required this.horarioFuncionamento,
    this.precoIngresso,
    required this.melhoresEpocas,
    required this.comoChegar,
    required this.contato,
    required this.imageUrl,
    required this.galeria,
    required this.dicasVisita,
    required this.acessibilidade,
    required this.tags,
    required this.avaliacaoMedia,
    this.createdAt,
    this.updatedAt,
  });

  factory LocalTuristico.fromJson(Map<String, dynamic> json) {
    return LocalTuristico(
      id: json['id'],
      nome: json['nome'] ?? 'Sem nome',
      tipo: json['tipo'] ?? 'outro',
      descricao: json['descricao'] ?? '',
      endereco: Endereco.fromJson(Map<String, dynamic>.from(json['endereco'] ?? {})),
      horarioFuncionamento: json['horarioFuncionamento'] ?? 'Horário não especificado',
      precoIngresso: (json['precoIngresso'] as num?)?.toDouble(),
      melhoresEpocas: List<String>.from(json['melhoresEpocas'] ?? []),
      comoChegar: json['comoChegar'] ?? '',
      contato: Contato.fromJson(Map<String, dynamic>.from(json['contato'] ?? {})),
      imageUrl: json['imageUrl'] ?? '',
      galeria: List<String>.from(json['galeria'] ?? []),
      dicasVisita: List<String>.from(json['dicasVisita'] ?? []),
      acessibilidade: json['acessibilidade'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      avaliacaoMedia: (json['avaliacaoMedia'] as num?)?.toDouble() ?? 0.0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'tipo': tipo,
      'descricao': descricao,
      'endereco': endereco.toJson(),
      'horarioFuncionamento': horarioFuncionamento,
      'precoIngresso': precoIngresso,
      'melhoresEpocas': melhoresEpocas,
      'comoChegar': comoChegar,
      'contato': contato.toJson(),
      'imageUrl': imageUrl,
      'galeria': galeria,
      'dicasVisita': dicasVisita,
      'acessibilidade': acessibilidade,
      'tags': tags,
      'avaliacaoMedia': avaliacaoMedia,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper methods
  String get precoFormatado {
    if (precoIngresso == null) return 'Gratuito';
    return 'R\$ ${precoIngresso!.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String get tipoFormatado {
    final tipos = {
      'historico': 'Histórico',
      'natural': 'Natural',
      'cultural': 'Cultural',
      'religioso': 'Religioso',
      'gastronomico': 'Gastronômico',
      'outro': 'Outro',
    };
    return tipos[tipo] ?? 'Outro';
  }
}

class Endereco {
  final String rua;
  final String cidade;
  final String provincia;
  final Coordenadas coordenadas;
  final String estado;
  final String pais;

  Endereco({
    required this.rua,
    required this.cidade,
    required this.provincia,
    required this.coordenadas, required this.estado, required this.pais,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      rua: json['rua'] ?? '',
      cidade: json['cidade'] ?? '',
      provincia: json['provincia'] ?? '',
      coordenadas: Coordenadas.fromJson(
          Map<String, dynamic>.from(json['coordenadas'] ?? {})), estado: '', pais: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rua': rua,
      'cidade': cidade,
      'provincia': provincia,
      'coordenadas': coordenadas.toJson(),
      'estado': estado,
      'pais': pais,
    };
  }

  String get enderecoCompleto {
    return '$rua, $cidade, $provincia';
  }
}
