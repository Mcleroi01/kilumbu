import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';

class HeroPage extends StatefulWidget {
  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  final List<Map<String, String>> heros = [
    {
      'nom': 'Agostinho Neto',
      'description': 'Premier président de l\'Angola indépendant et figure clé dans la lutte pour l’indépendance.',
      'image': 'assets/images/heros/agostinho_neto.jpg',
    },
    {
      'nom': 'António Agostinho',
      'description': 'Militant du MPLA et poète engagé, il a marqué l’histoire du pays par ses idées progressistes.',
      'image': 'assets/images/heros/antonio_agostinho.jpg',
    },
    {
      'nom': 'Rainha Nzinga',
      'description': 'Reine du Ndongo et du Matamba, résistante emblématique face à la colonisation portugaise.',
      'image': 'assets/images/heros/nzinga.jpg',
    },
    {
      'nom': 'Deolinda Rodrigues',
      'description': 'Figure féminine importante du MPLA, militante pour l’émancipation et la liberté.',
      'image': 'assets/images/heros/deolinda.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.star,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🎖️ En-tête
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/heros/heros-cover.jpg'),
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
                        'Héros Nacionais de Angola',
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

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'L’histoire de l’Angola est marquée par des hommes et des femmes qui ont lutté pour la liberté, l’identité et la souveraineté de leur peuple. Voici quelques figures majeures de cette lutte.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ),

            const SizedBox(height: 20),

            // 🧑🏿‍🏫 Liste des héros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: heros.map((hero) => _buildHeroCard(hero)).toList(),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(Map<String, String> hero) {
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
          // 📷 Image du héros
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              hero['image']!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // 📃 Description
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hero['nom']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hero['description']!,
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
