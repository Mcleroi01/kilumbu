import 'dart:ui';
import 'package:Kilumbu/const/bottom_floating_button.dart';
import 'package:Kilumbu/const/info_tile.dart';
import 'package:Kilumbu/parque_naturel/model/parcnaturel.dart';
import 'package:Kilumbu/parque_naturel/service/parc_naturel_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParcNaturelDetailPage extends StatefulWidget {
  final int id;

  const ParcNaturelDetailPage({super.key, required this.id});

  @override
  State<ParcNaturelDetailPage> createState() => _ParcNaturelDetailPageState();
}

class _ParcNaturelDetailPageState extends State<ParcNaturelDetailPage> {
  late Future<ParcNaturel> parcFuture;

  @override
  void initState() {
    super.initState();
    parcFuture = ParcNaturelService().getParcNaturelById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParcNaturel>(
      future: parcFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Erro ao carregar o parque.")),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text("Parque não encontrado.")),
          );
        }

        final parc = snapshot.data!;

        return Scaffold(
          body: Stack(
            children: [
              // 🌁 Image de fond
              Positioned.fill(
                child: Image.network(
                  parc.imagePrincipale,
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
                      parc.nom,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [const Shadow(blurRadius: 6, color: Colors.black45)],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            parc.imagePrincipale,
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
                              parc.nom,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              parc.localisation,
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
                                InfoTile(icon: Icons.date_range_outlined, label: "Criação", value: parc.dateCreation),
                                InfoTile(icon: Icons.area_chart, label: "Área", value: parc.superficie),
                                InfoTile(icon: Icons.thermostat, label: "Climat", value: parc.climat),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Onglets
                            const TabBar(
                              labelColor: Color(0xFFDD1C1A),
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Color(0xFFDD1C1A),
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              tabs: [
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
                                  // Aperçu
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      parc.description,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 13,
                                        color: Colors.grey,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),

                                  // Détails
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            parc.imagePrincipale,
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 16),

                                        if (parc.images.isNotEmpty)
                                          SizedBox(
                                            height: 120,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: parc.images.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                      parc.images[index],
                                                      width: 150,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        const SizedBox(height: 24),
                                        _infoCard("📍 Localização", parc.localisation),
                                        _infoCard("📅 Data de Criação", parc.dateCreation),
                                        _infoCard("🌐 Superfície", parc.superficie),
                                        _infoCard("🌿 Tipo de Vegetação", parc.typeVegetation),
                                        _infoCard("☀️ Clima", parc.climat),
                                        _infoCard("🦁 Espécies Protegidas", parc.especesProtegees.join(", ")),
                                        _infoCard("🎯 Atividades", parc.activitesDisponibles),
                                        _infoCard("🧭 Acesso", parc.acces),
                                        _infoCard("📝 Conselhos", parc.conseilsVisite),
                                        if (parc.siteWeb.isNotEmpty)
                                          _infoCard("🔗 Website", parc.siteWeb),
                                        _infoCard("🏛️ Património da UNESCO", parc.patrimoineUnesco ? "Sim" : "Não"),
                                      ],
                                    ),
                                  ),

                                  // Locaux à visiter
                                  const Center(child: Text("Em breve…")),
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
      },
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }

  void _onPressed() {
    // Action future ici
  }
}
