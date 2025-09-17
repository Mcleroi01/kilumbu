import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/parque_naturel/model/parcnaturel.dart';
import 'package:Kilumbu/parque_naturel/page/parc_naturel_detail_page.dart';
import 'package:Kilumbu/parque_naturel/service/parc_naturel_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParquetNaturelPage extends StatefulWidget {
  const ParquetNaturelPage({super.key});

  @override
  State<ParquetNaturelPage> createState() => _ParquetNaturelPageState();
}

class _ParquetNaturelPageState extends State<ParquetNaturelPage> {
  final ParcNaturelService parquetNaturelService = ParcNaturelService();
  List<ParcNaturel> parcnaturels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadParcs();
  }

  Future<void> _loadParcs() async {
    try {
      final data = await parquetNaturelService.getAllParcs();
      setState(() {
        parcnaturels = data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du chargement des parcs: $e");
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Parques Naturais',
        actionIcon: Icons.eco_outlined,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Parques Naturais de Angola',
              subtitle: 'Explore as belezas naturais e a biodiversidade do país.',
            ),

            const SizedBox(height: 20),
            Text(
              "Existem parques nacionais e reservas naturais em quase todas as províncias angolanas. "
                  "O país participa de acordos de áreas de proteção transnacionais. Juntas, "
                  "essas áreas cobrem cerca de 82.000 km², representando aproximadamente 6,6% do território nacional. "
                  "Incluindo as 18 áreas de proteção florestal e zonas de proteção local, "
                  "a área protegida em Angola totaliza 188.650 km², ou seja, mais de 15% do território.",
              style: GoogleFonts.poppins(
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
            Image.network(
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
                style:  GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  shadows: [
                    const Shadow(
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



