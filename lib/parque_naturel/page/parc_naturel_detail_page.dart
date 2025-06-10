import 'dart:ui';
import 'package:Kilumbu/const/bottom_floating_button.dart';
import 'package:Kilumbu/const/info_tile.dart';
import 'package:Kilumbu/parque_naturel/model/parcnaturel.dart';
import 'package:Kilumbu/parque_naturel/service/parc_naturel_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ParcNaturelDetailPage extends StatelessWidget {
  final int id;

  const ParcNaturelDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ParcNaturelService service = ParcNaturelService();
    final ParcNaturel parcNaturel = service.getParcNaturelById(id);

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.asset(
              parcNaturel.imagePrincipale,
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
                  parcNaturel.nom,
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
                        parcNaturel.imagePrincipale,
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
                          parcNaturel.nom,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          parcNaturel.localisation,
                          style: GoogleFonts.poppins(
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
                            InfoTile(icon:Icons.date_range_outlined, label: "Criação", value:parcNaturel.dateCreation),
                            InfoTile(icon:Icons.area_chart, label:"Área", value:parcNaturel.superficie),
                            InfoTile(icon:Icons.thermostat,label: "Climat", value:parcNaturel.climat),
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
                            Tab(text: "Visão geral"),
                            Tab(text: "Detalhes"),
                            Tab(text: "Locais a Visitar"),
                          ],
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 600,
                          child: TabBarView(
                            children: [
                              // 🧾 Aperçu
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  parcNaturel.description,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                              ),

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
                                        parcNaturel.imagePrincipale,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // 🖼️ Galerie
                                    if (parcNaturel.images.isNotEmpty)
                                      SizedBox(
                                        height: 120,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: parcNaturel.images.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 8),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.asset(
                                                  parcNaturel.images[index],
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
                                    _infoCard("📍 Localização", parcNaturel.localisation),
                                    _infoCard("📅 Data de Criação", parcNaturel.dateCreation),
                                    _infoCard("🌐 Superfície", parcNaturel.superficie),
                                    _infoCard("🌿 Tipo de Vegetação", parcNaturel.typeVegetation),
                                    _infoCard("☀️ Clima", parcNaturel.climat),
                                    _infoCard("🦁 Espécies Protegidas", parcNaturel.especesProtegees.join(", ")),
                                    _infoCard("🎯 Atividades", parcNaturel.activitesDisponibles),
                                    _infoCard("🧭 Acesso", parcNaturel.acces),
                                    _infoCard("📝 Conselhos", parcNaturel.conseilsVisite),
                                    if (parcNaturel.siteWeb.isNotEmpty)
                                      _infoCard("🔗 Website", parcNaturel.siteWeb),
                                    _infoCard("🏛️ Património da UNESCO", parcNaturel.patrimoineUnesco ? "Sim" : "Não"),

                                  ],
                                ),
                              ),
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

          BottomFloatingButton(onPressed: _onPressed),


        ],
      ),
    );
  }


  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style:  GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
  _onPressed(){
    return null;
  }
}
