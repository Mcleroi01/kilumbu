import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';

class LanguePage extends StatefulWidget {
  @override
  State<LanguePage> createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  final List<Map<String, String>> langues = [
    {
      'nom': 'Kimbundu',
      'description':
      'Parlé principalement à Luanda et dans les régions environnantes. C’est l’une des langues nationales les plus influentes.',
      'image': 'assets/images/langues/kimbundu.jpg',
    },
    {
      'nom': 'Umbundu',
      'description':
      'Langue majoritaire dans le sud du pays, surtout dans les provinces comme Huíla et Benguela.',
      'image': 'assets/images/langues/umbundu.jpg',
    },
    {
      'nom': 'Kikongo',
      'description':
      'Langue parlée dans le nord-ouest de l’Angola, notamment dans la province du Zaire.',
      'image': 'assets/images/langues/kikongo.jpg',
    },
    {
      'nom': 'Chokwe',
      'description':
      'Parlée dans l’est du pays, notamment dans la province de Lunda Norte.',
      'image': 'assets/images/langues/chokwe.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.language,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🌅 En-tête avec image floutée
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/langues/langues-cover.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                    const Center(
                      child: Text(
                        'Línguas Nacionais de Angola',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 📖 Introduction
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Angola é um país com grande diversidade linguística. Além do português, que é a língua oficial, existem várias línguas nacionais que fazem parte da identidade cultural do país.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ),

            const SizedBox(height: 20),

            // 📚 Cartes de langues
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: langues.map((langue) => _buildLangueCard(langue)).toList(),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLangueCard(Map<String, String> langue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🖼 Image langue
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              langue['image']!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // 📄 Infos langue
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    langue['nom']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    langue['description']!,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
