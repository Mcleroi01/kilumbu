import 'dart:ui';
import 'package:Kilumbu/const/bottom_floating_button.dart';
import 'package:Kilumbu/const/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:Kilumbu/province/model/province.dart';
import 'package:Kilumbu/province/service/province_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ProvinceDetailsPage extends StatefulWidget {
  final int id;

  const ProvinceDetailsPage({super.key, required this.id});

  @override
  State<ProvinceDetailsPage> createState() => _ProvinceDetailsPageState();
}

class _ProvinceDetailsPageState extends State<ProvinceDetailsPage> {
  Province? province;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProvince();
  }

  Future<void> _loadProvince() async {
    try {
      final result = await ProvinceService().getProvinceById(widget.id);
      setState(() {
        province = result;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao carregar a província")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || province == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.network(
              province!.imagePath,
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

          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.white),
                title: Text(
                  province!.nom,
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
                        province!.imagePath,
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
                        Text(province!.nom, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30)),
                        Text(province!.capitale, style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey)),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTile(icon: Icons.location_city, label: "Capital", value: province!.capitale),
                            InfoTile(icon: Icons.area_chart, label: "Superfície", value: province!.superficie),
                            InfoTile(icon: Icons.people, label: "População", value: province!.population),
                          ],
                        ),
                        const SizedBox(height: 24),

                        TabBar(
                          labelColor: const Color(0xFFDD1C1A),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: const Color(0xFFDD1C1A),
                          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: "Visão geral"),
                            Tab(text: "Detalhes"),
                            Tab(text: "Avis"),
                          ],
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 500,
                          child: TabBarView(
                            children: [
                              Text(
                                province!.description,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),

                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        province!.imagePath,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    if (province!.photos.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Galeria", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 100,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: province!.photos.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(12),
                                                    child: Image.network(
                                                      province!.photos[index],
                                                      width: 140,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),

                                    const SizedBox(height: 24),

                                    Column(
                                      children: [
                                        _infoCard("📍 Capital", province!.capitale),
                                        _infoCard("👥 População", province!.population),
                                        _infoCard("📐 Superfície", province!.superficie),
                                        _infoCard("☀️ Clima", province!.climat),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

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

          BottomFloatingButton(onPressed: _onPressed),
        ],
      ),
    );
  }

  void _onPressed() {}

  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(fontSize: 13),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
