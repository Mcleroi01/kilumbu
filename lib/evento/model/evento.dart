import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalEvento {
  final String nome;
  final String endereco;
  final String? cidade;
  final String? coordenadas; // Format: "latitude,longitude"

  LocalEvento({
    required this.nome,
    required this.endereco,
    this.cidade,
    this.coordenadas,
  });

  factory LocalEvento.fromJson(Map<String, dynamic> json) {
    return LocalEvento(
      nome: json['nome'] ?? 'Local não especificado',
      endereco: json['endereco'] ?? 'Endereço não disponível',
      cidade: json['cidade'],
      coordenadas: json['coordenadas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'endereco': endereco,
      if (cidade != null) 'cidade': cidade,
      if (coordenadas != null) 'coordenadas': coordenadas,
    };
  }
}

class Ingresso {
  final String tipo;
  final double preco;
  final String? descricao;
  final int? quantidadeDisponivel;
  final bool vendasOnline;
  final String? linkVenda;

  Ingresso({
    required this.tipo,
    required this.preco,
    this.descricao,
    this.quantidadeDisponivel,
    this.vendasOnline = false,
    this.linkVenda,
  });

  factory Ingresso.fromJson(Map<String, dynamic> json) {
    return Ingresso(
      tipo: json['tipo'] ?? 'Ingresso',
      preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
      descricao: json['descricao'],
      quantidadeDisponivel: json['quantidadeDisponivel'],
      vendasOnline: json['vendasOnline'] ?? false,
      linkVenda: json['linkVenda'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'preco': preco,
      if (descricao != null) 'descricao': descricao,
      if (quantidadeDisponivel != null) 'quantidadeDisponivel': quantidadeDisponivel,
      'vendasOnline': vendasOnline,
      if (linkVenda != null) 'linkVenda': linkVenda,
    };
  }

  String get precoFormatado => 'R\$preco';
}

class Evento {
  final String? id;
  final String titulo;
  final String descricao;
  final String tipo; // cultural, esportivo, musical, gastronomico, religioso, outro
  final LocalEvento local;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final TimeOfDay? horarioInicio;
  final TimeOfDay? horarioFim;
  final String? imageUrl;
  final List<String> galeria;
  final List<Ingresso> ingressos;
  final String? website;
  final String? telefoneContato;
  final String? emailContato;
  final List<String> tags;
  final bool ativo;
  final int capacidadeMaxima;
  final int idadeMinima;
  final bool acessibilidade;
  final String? observacoes;
  final String? criadoPor;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Evento({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.local,
    required this.dataInicio,
    this.dataFim,
    this.horarioInicio,
    this.horarioFim,
    this.imageUrl,
    List<String>? galeria,
    List<Ingresso>? ingressos,
    this.website,
    this.telefoneContato,
    this.emailContato,
    List<String>? tags,
    this.ativo = true,
    this.capacidadeMaxima = 0,
    this.idadeMinima = 0,
    this.acessibilidade = false,
    this.observacoes,
    this.criadoPor,
    this.createdAt,
    this.updatedAt,
  })  : galeria = galeria ?? [],
        ingressos = ingressos ?? [],
        tags = tags ?? [];

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'],
      titulo: json['titulo'] ?? 'Sem título',
      descricao: json['descricao'] ?? '',
      tipo: json['tipo'] ?? 'outro',
      local: LocalEvento.fromJson(Map<String, dynamic>.from(json['local'] ?? {})),
      dataInicio: (json['dataInicio'] as Timestamp).toDate(),
      dataFim: json['dataFim'] != null ? (json['dataFim'] as Timestamp).toDate() : null,
      horarioInicio: json['horarioInicio'] != null 
          ? TimeOfDay(
              hour: int.parse(json['horarioInicio'].split(':')[0]),
              minute: int.parse(json['horarioInicio'].split(':')[1]),
            )
          : null,
      horarioFim: json['horarioFim'] != null
          ? TimeOfDay(
              hour: int.parse(json['horarioFim'].split(':')[0]),
              minute: int.parse(json['horarioFim'].split(':')[1]),
            )
          : null,
      imageUrl: json['imageUrl'],
      galeria: List<String>.from(json['galeria'] ?? []),
      ingressos: (json['ingressos'] as List<dynamic>?)
              ?.map((e) => Ingresso.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      website: json['website'],
      telefoneContato: json['telefoneContato'],
      emailContato: json['emailContato'],
      tags: List<String>.from(json['tags'] ?? []),
      ativo: json['ativo'] ?? true,
      capacidadeMaxima: json['capacidadeMaxima'] ?? 0,
      idadeMinima: json['idadeMinima'] ?? 0,
      acessibilidade: json['acessibilidade'] ?? false,
      observacoes: json['observacoes'],
      criadoPor: json['criadoPor'],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'tipo': tipo,
      'local': local.toJson(),
      'dataInicio': Timestamp.fromDate(dataInicio),
      if (dataFim != null) 'dataFim': Timestamp.fromDate(dataFim!),
      if (horarioInicio != null) 'horarioInicio': '${horarioInicio!.hour}:${horarioInicio!.minute.toString().padLeft(2, '0')}',
      if (horarioFim != null) 'horarioFim': '${horarioFim!.hour}:${horarioFim!.minute.toString().padLeft(2, '0')}',
      if (imageUrl != null) 'imageUrl': imageUrl,
      'galeria': galeria,
      'ingressos': ingressos.map((e) => e.toJson()).toList(),
      if (website != null) 'website': website,
      if (telefoneContato != null) 'telefoneContato': telefoneContato,
      if (emailContato != null) 'emailContato': emailContato,
      'tags': tags,
      'ativo': ativo,
      'capacidadeMaxima': capacidadeMaxima,
      'idadeMinima': idadeMinima,
      'acessibilidade': acessibilidade,
      if (observacoes != null) 'observacoes': observacoes,
      if (criadoPor != null) 'criadoPor': criadoPor,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper methods
  String getDataFormatada(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final startDate = dateFormat.format(dataInicio);
    final startTime = horarioInicio != null 
        ? ' às ${horarioInicio!.format(context)}' 
        : '';
    
    if (dataFim == null) {
      return '$startDate$startTime';
    }
    
    final endDate = dateFormat.format(dataFim!);
    final endTime = horarioFim != null 
        ? ' até ${horarioFim!.format(context)}' 
        : '';
    
    return startDate == endDate
        ? '$startDate$startTime -$endTime'
        : '$startDate$startTime a $endDate$endTime';
  }

  String get tipoFormatado {
    final tipos = {
      'cultural': 'Cultural',
      'esportivo': 'Esportivo',
      'musical': 'Musical',
      'gastronomico': 'Gastronômico',
      'religioso': 'Religioso',
      'outro': 'Outro',
    };
    return tipos[tipo] ?? 'Outro';
  }

  bool get isFree => ingressos.every((ingresso) => ingresso.preco == 0);
  
  bool get isHappeningNow {
    final now = DateTime.now();
    final isAfterStart = now.isAfter(dataInicio);
    final isBeforeEnd = dataFim == null || now.isBefore(dataFim!.add(const Duration(days: 1)));
    return isAfterStart && isBeforeEnd;
  }
  
  bool get isUpcoming => DateTime.now().isBefore(dataInicio);
  
  bool get isPast => dataFim != null && DateTime.now().isAfter(dataFim!);
}

extension TimeOfDayExtension on TimeOfDay {
  String format(BuildContext context) {
    return MaterialLocalizations.of(context).formatTimeOfDay(this);
  }
}
