import 'dart:ui';
import 'package:Kilumbu/const/bottom_floating_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class CapitalPage extends StatefulWidget {
  const CapitalPage({super.key});

  @override
  State<CapitalPage> createState() => _CapitalPageState();
}

class _CapitalPageState extends State<CapitalPage> {
  @override
  Widget build(BuildContext context) {
    const String luandaDescription ='''
Luanda é a capital e a maior cidade de Angola. Localizada na costa atlântica do país, Luanda é um importante centro político, econômico e cultural. Fundada pelos portugueses em 1576, é uma cidade histórica com uma mistura vibrante de arquitetura colonial e moderna.

A cidade abriga instituições governamentais, museus, universidades e uma das economias urbanas mais dinâmicas de África. O seu porto é um dos mais movimentados da região e desempenha um papel essencial no comércio angolano.

Luanda é também conhecida pela sua baía deslumbrante, praias como a Ilha do Mussulo, e uma vida cultural rica, incluindo música kizomba e semba, moda e gastronomia.
                ''';
    return Scaffold(

      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/capital.jpg',
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
                  'Luanda',
                  style:  GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [const Shadow(blurRadius: 6, color: Colors.black45)],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/capital.jpg',
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
                          'Luanda',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Costa oeste de Angola, banhada pelo Oceano Atlântico',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Infos principales
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoTile(Icons.date_range_outlined, "Fundação", '1576'),
                            _infoTile(Icons.area_chart, "Área", '116 km²'),
                            _infoTile(Icons.thermostat, "Clima", 'Tropical seco'),

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
                              // 🧾 Aperçu
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Text(luandaDescription
                                  ,
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
                                        'assets/images/capital.jpg' ,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 16),



                                    // Autres contenus si besoin
                                    const SizedBox(height: 24),
                                    // 📋 Informations en Card
                                    _infoCard("📍 Localização", 'Costa oeste de Angola, banhada pelo Oceano Atlântico'),
                                    _infoCard("📅 Data de Fundação", '25 de janeiro de 1576'),
                                    _infoCard("🌐 Superfície", '116 km²'),
                                    _infoCard("☀️ Clima", 'Tropical seco (com pouca chuva entre maio e setembro)'),
                                    _infoCard("🎯 Atividades", 'Turismo histórico, vida noturna, praias, compras'),
                                    _infoCard("🧭 Acesso", 'Através do Aeroporto Internacional 4 de Fevereiro e estradas principais'),
                                    _infoCard("📝 Conselhos", 'Evitar circular em áreas isoladas à noite; hidratar-se bem no calor'),


                                  ],
                                ),
                              ),

                              // 📸 Locais a Visitar
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("📸 Galeria", style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 12),

                                    // 🌄 Galerie horizontale
                                    SizedBox(
                                      height: 160,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          _placeImage("assets/images/fortaleza.jpg"),
                                          _placeImage("assets/images/ilha.jpeg"),
                                          _placeImage("assets/images/musseque.jpg"),
                                          _placeImage("assets/images/miradouro.jpg"),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 24),
                                    Text("📍 Lugares Imperdíveis", style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 12),

                                    _placeTile("Fortaleza de São Miguel", "Construída em 1576 com vista para a baía"),
                                    _placeTile("Ilha do Cabo", "Praias, bares e vida noturna à beira-mar"),
                                    _placeTile("Museu Nacional de Antropologia", "História e cultura de Angola"),
                                    _placeTile("Miradouro da Lua", "Paisagem geológica única a poucos km de Luanda"),
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

          BottomFloatingButton(onPressed: _action)
        ],
      ),
    );
  }

  Widget _placeImage(String path) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          path,
          width: 200,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _placeTile(String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: const Icon(Icons.place_outlined, color: Colors.redAccent),
      title: Text(title, style:  GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

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
            Text(label, style:  GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
            Text(value, style:  GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(width: 4),

      ],
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

  _action(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  const CapitalPage()),
    );
  }
}

