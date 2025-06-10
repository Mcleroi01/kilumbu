import 'dart:ui';
import 'package:Kilumbu/const/bottom_floating_button.dart';
import 'package:Kilumbu/const/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:Kilumbu/province/model/province.dart';
import 'package:Kilumbu/province/service/province_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  style:  GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          province.capitale,
                          style:  GoogleFonts.poppins(
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
                            InfoTile(icon:Icons.location_city, label: "Capitale", value:province.capitale),
                            InfoTile(icon:Icons.area_chart, label:"Superficie", value:province.superficie),
                            InfoTile(icon:Icons.thermostat,label: "Climat", value:province.climat),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Onglets
                        TabBar(
                          labelColor: const Color(0xFFDD1C1A),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: const Color(0xFFDD1C1A),
                          labelStyle:  GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: "Visão geral"),
                            Tab(text: "Detalhes"),
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
                                style:  GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),

                              // Détail
                              // 🧩 Détails
                              SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🌄 Image principale
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        province.imagePath,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // 🖼️ Galerie
                                    if (province.photos.isNotEmpty)
                                      SizedBox(
                                        height: 120,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: province.photos.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.asset(
                                                  province.photos[index],
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                    // Autres contenus si besoin
                                    const SizedBox(height: 24),
                                    // 📋 Informations en Card


                                  ],
                                ),
                              ),

                              // Avis
                              const Center(child: Text("Aucun avis pour le moment.")),
                            ],
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

          BottomFloatingButton(onPressed: _onPressed)
        ],
      ),
    );
  }

  _onPressed(){}

}
