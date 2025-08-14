class PratoCulinario {
  final String? id;
  final String nome;
  final String? nomeAlternativo;
  final String descricao;
  final List<Ingrediente> ingredientes;
  final List<String> modoPreparo;
  final int tempoPreparo;
  final String dificuldade;
  final int porcoes;
  final String regiao;
  final String? origemHistorica;
  final List<String> curiosidades;
  final String imageUrl;
  final List<String> galeria;
  final String? videoReceita;
  final String? epocaEspecial;
  final List<String> tags;

  PratoCulinario({
    this.id,
    required this.nome,
    this.nomeAlternativo,
    required this.descricao,
    required this.ingredientes,
    required this.modoPreparo,
    required this.tempoPreparo,
    required this.dificuldade,
    required this.porcoes,
    required this.regiao,
    this.origemHistorica,
    required this.curiosidades,
    required this.imageUrl,
    required this.galeria,
    this.videoReceita,
    this.epocaEspecial,
    required this.tags,
  });

  factory PratoCulinario.fromJson(Map<String, dynamic> data) {
    return PratoCulinario(
      id: data['id'],
      nome: data['nome'] ?? 'Sem nome',
      nomeAlternativo: data['nomeAlternativo'],
      descricao: data['descricao'] ?? '',
      ingredientes: (data['ingredientes'] as List?)
              ?.map((i) => Ingrediente.fromJson(i))
              .toList() ??
          [],
      modoPreparo: List<String>.from(data['modoPreparo'] ?? []),
      tempoPreparo: data['tempoPreparo'] ?? 0,
      dificuldade: data['dificuldade'] ?? 'médio',
      porcoes: data['porcoes'] ?? 1,
      regiao: data['regiao'] ?? 'Região não especificada',
      origemHistorica: data['origemHistorica'],
      curiosidades: List<String>.from(data['curiosidades'] ?? []),
      imageUrl: data['imageUrl'] ?? '',
      galeria: List<String>.from(data['galeria'] ?? []),
      videoReceita: data['videoReceita'],
      epocaEspecial: data['epocaEspecial'],
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'nomeAlternativo': nomeAlternativo,
      'descricao': descricao,
      'ingredientes': ingredientes.map((i) => i.toJson()).toList(),
      'modoPreparo': modoPreparo,
      'tempoPreparo': tempoPreparo,
      'dificuldade': dificuldade,
      'porcoes': porcoes,
      'regiao': regiao,
      'origemHistorica': origemHistorica,
      'curiosidades': curiosidades,
      'imageUrl': imageUrl,
      'galeria': galeria,
      'videoReceita': videoReceita,
      'epocaEspecial': epocaEspecial,
      'tags': tags,
    };
  }
}

class Ingrediente {
  final String nome;
  final String quantidade;
  final bool opcional;

  Ingrediente({
    required this.nome,
    required this.quantidade,
    required this.opcional,
  });

  factory Ingrediente.fromJson(Map<String, dynamic> data) {
    return Ingrediente(
      nome: data['nome'] ?? '',
      quantidade: data['quantidade'] ?? '',
      opcional: data['opcional'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidade': quantidade,
      'opcional': opcional,
    };
  }
}
