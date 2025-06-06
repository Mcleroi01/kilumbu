import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';

class CapitalPage extends StatefulWidget {
  @override
  State<CapitalPage> createState() => _CapitalPageState();
}

class _CapitalPageState extends State<CapitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.info_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🖼 Image en-tête avec flou et titre
            Container(
              height: 300,
              width: double.infinity,

              decoration: BoxDecoration(

                image: const DecorationImage(
                  image: AssetImage('assets/images/capital.jpg'), // Remplace avec une image de Luanda
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 6),
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                    const Center(
                      child: Text(
                        'Luanda',
                        style: TextStyle(
                          fontSize: 28,
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

            // 📝 Description de Luanda
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '''
Luanda é a capital e a maior cidade de Angola. Localizada na costa atlântica do país, Luanda é um importante centro político, econômico e cultural. Fundada pelos portugueses em 1576, é uma cidade histórica com uma mistura vibrante de arquitetura colonial e moderna.

A cidade abriga instituições governamentais, museus, universidades e uma das economias urbanas mais dinâmicas de África. O seu porto é um dos mais movimentados da região e desempenha um papel essencial no comércio angolano.

Luanda é também conhecida pela sua baía deslumbrante, praias como a Ilha do Mussulo, e uma vida cultural rica, incluindo música kizomba e semba, moda e gastronomia.
                ''',
                  style: const TextStyle(fontSize: 14, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📌 Informations clés
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  InfoRow(label: '📍 Localização', value: 'Litoral atlântico'),
                  InfoRow(label: '👥 População', value: 'Mais de 8 milhões'),
                  InfoRow(label: '🕰 Fundada', value: '1576'),
                  InfoRow(label: '🌍 Importância', value: 'Capital política e econômica'),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// 🔹 Widget pour ligne d'information
class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
