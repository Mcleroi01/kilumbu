import 'dart:ui';
import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/parque_naturel/model/parcnaturel.dart';
import 'package:Kilumbu/parque_naturel/page/parc_naturel_detail_page.dart';
import 'package:Kilumbu/parque_naturel/service/parc_naturel_service.dart';
import 'package:flutter/material.dart';

class ParquetNaturelPage extends StatefulWidget {
  @override
  State<ParquetNaturelPage> createState() => _ParquetNaturelPageState();
}

class _ParquetNaturelPageState extends State<ParquetNaturelPage> {
  final ParcNaturelService parquetNaturelService = ParcNaturelService();
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final List<ParcNaturel> parcnaturels = parquetNaturelService.getParcsNaturels();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.eco_outlined,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔝 Bannière
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/angola.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Parques Naturais de Angola',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Explore as belezas naturais e a biodiversidade do país.',
                            style: TextStyle(fontSize: 14, color: Colors.white70),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              "Existem parques nacionais e reservas naturais em quase todas as províncias angolanas. "
                  "O país participa de acordos de áreas de proteção transnacionais. Juntas, "
                  "essas áreas cobrem cerca de 82.000 km², representando aproximadamente 6,6% do território nacional. "
                  "Incluindo as 18 áreas de proteção florestal e zonas de proteção local, "
                  "a área protegida em Angola totaliza 188.650 km², ou seja, mais de 15% do território.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // 🧑‍🏫 Liste des Présidents en grille
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: parcnaturels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmall ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final parcnaturel = parcnaturels[index];
                return _themeCard(
                  context,
                  parcnaturel.nom,
                  parcnaturel.imagePrincipale,
                  ParcNaturelDetailPage(id: parcnaturel.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _themeCard(BuildContext context, String title, String imagePath, Widget destinationPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black54,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



