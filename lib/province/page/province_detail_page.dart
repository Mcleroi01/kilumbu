import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:Kilumbu/province/model/province.dart';
import 'package:Kilumbu/province/service/province_service.dart';

class ProvinceDetailsPage extends StatelessWidget {
  final int id;

  const ProvinceDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ProvinceService service = ProvinceService();
    final Province province = service.getProvinceById(id);

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.asset(
              province.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Effet flou
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          // 📜 Contenu scrollable
          CustomScrollView(
            slivers: [
              // 🔽 AppBar flexible
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.white),
                title: Text(
                  province.nom,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black45)],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        province.imagePath,
                        fit: BoxFit.cover,
                      ),
                      Container(color: Colors.black.withOpacity(0.3)),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Titre
                        Text(
                          province.nom,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          province.capitale,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Infos principales
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoTile(Icons.location_city, "Capitale", province.capitale),
                            _infoTile(Icons.area_chart, "Superficie", province.superficie),
                            _infoTile(Icons.thermostat, "Climat", province.climat),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Onglets
                        TabBar(
                          labelColor: const Color(0xFFDD1C1A),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: const Color(0xFFDD1C1A),
                          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: "Aperçu"),
                            Tab(text: "Détail"),
                            Tab(text: "Avis"),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Contenu des tabs
                        SizedBox(
                          height: 500, // adapte selon ta mise en page
                          child: TabBarView(
                            children: [
                              // Aperçu
                              Text(
                                province.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),

                              // Détail
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Carte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 12),
                                  if (province.mapPath is List<String>)
                                    SizedBox(
                                      height: 120,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: (province.mapPath as List<String>).map((path) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Image.asset(
                                                path,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  else
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        province.mapPath.toString(),
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                ],
                              ),

                              // Avis
                              const Center(child: Text("Aucun avis pour le moment.")),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Photos
                        const Text("Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: province.photos.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    province.photos[index],
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),

          // 🔘 Bouton flottant bas
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Explorer maintenant",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDD1C1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Commencer", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Affiche les infos capitale, superficie, climat, etc.
  Widget _infoTile(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon, color: const Color(0xFFDD1C1A), size: 22),
        ),
        const SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(width: 4),

      ],
    );
  }

  /// Formate le texte en paragraphes stylisés
  List<InlineSpan> _buildArticleParagraphs(String text) {
    final paragraphs = text.trim().split('\n\n');

    return paragraphs.map((paragraph) {
      final firstLetter = paragraph.substring(0, 1);
      final rest = paragraph.substring(1);
      return TextSpan(
        children: [
          WidgetSpan(child: SizedBox(height: 16)),
          TextSpan(
            text: firstLetter,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          TextSpan(text: rest + '\n\n'),
        ],
      );
    }).toList();
  }

  _onPressed(){
    return null;
  }
}
