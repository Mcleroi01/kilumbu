import 'package:Kilumbu/Feriados/page/Feriados_page.dart';
import 'package:Kilumbu/capital/page/capital_page.dart';
import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/cozinha/page/cozinha_page.dart';
import 'package:Kilumbu/hero/page/hero_page.dart';
import 'package:Kilumbu/histoire/page/histoire_page.dart';
import 'package:Kilumbu/hymne_national/page/hymne_national.dart';
import 'package:Kilumbu/langue/page/langue_page.dart';
import 'package:Kilumbu/musica/page/musica_page.dart';
import 'package:Kilumbu/parque_naturel/page/parque_naturel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Kilumbu/province/page/provinces_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🎉 Bloc Bienvenue
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Bem-vindo ao Kilumbu 🇦🇴',
              subtitle: 'Descubra a história, a cultura e os heróis da nossa nação.',
            ),


            const SizedBox(height: 30),

            // 📍 Catégories Slider
            SizedBox(
              height: 50,
              width: screenWidth,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _categoryChip(  context,Icons.history_edu, 'História',const HistoirePage()),
                  _categoryChip(  context,Icons.music_note, 'Música',const MusicaPage()),
                  _categoryChip(  context,Icons.emoji_people, 'Herói',const HeroPage()),
                  _categoryChip(  context,Icons.restaurant_menu, 'Cozinha',const CozinhaPage()),
                  _categoryChip(  context,Icons.festival, 'Feriados',const FeriadosPage()),
                  _categoryChip(  context,Icons.map, 'Províncias',const ProvincesPage()),
                ],
              ),
            ),

            const SizedBox(height: 30),
            // 🔳 Grid des cartes thématiques
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Temas em Destaque',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: isSmall ? 2 : 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _themeCard(context,'Hino Nacional', 'assets/images/hymne.jpg',const HymneNationalPage()),
                    _themeCard(context,'Capitais', 'assets/images/capital.jpg',const CapitalPage()),
                    _themeCard(context,'Parques Naturais', 'assets/images/parc.jpg',const ParquetNaturelPage()),
                    _themeCard(context,'Heróis Nacionais', 'assets/images/heroi.jpg',const HeroPage()),
                    _themeCard(
                        context,'Línguas Nacionais', 'assets/images/langues.jpg',const LanguePage()),
                    _themeCard(context,'Províncias', 'assets/images/provinces.jpg',const ProvincesPage()),
                  ],
                ),
              ],
            ),

            // Ajoute après le slider de catégories

            const SizedBox(height: 30),

            Container(
              width: double.infinity,

              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.darken,
                        ),
                        child: Image.asset(
                          'assets/images/angola.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            '🇦🇴 Angola em Destaque',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text('• Capital: Luanda', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Superfície: 1.246.700 km²', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• População: ~33 milhões', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Língua oficial: Português', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Moeda: Kwanza (AOA)', style: GoogleFonts.poppins(color: Colors.white)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text('• Indépendance: 11 nov. 1975', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Président: João Lourenço', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Hymne: Angola Avante', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Drapeau: 🇦🇴', style: GoogleFonts.poppins(color: Colors.white)),
                                    Text('• Devise: Unidade e Progresso', style: GoogleFonts.poppins(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),



            const SizedBox(height: 30),
            _buildAdageSlider(),

          ],
        ),
      ),
    );
  }

  Widget _categoryChip(BuildContext context, IconData icon, String label, Widget destinationPage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF000000).withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF000000)),
            const SizedBox(width: 6),
            Text(
              label,
              style:  GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF000000),
              ),
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


  Widget _buildAdageSlider() {
    final List<Map<String, String>> adagesAngolais = [
      {
        'author': 'Agostinho Neto',
        'quote': 'A luta continua, a vitória é certa.'
      },
      {
        'author': 'Pepetela',
        'quote': 'A história é escrita com o sangue do povo.'
      },
      {
        'author': 'José Eduardo dos Santos',
        'quote': 'Paz é o principal factor do desenvolvimento.'
      },
      {
        'author': 'António Agostinho Neto',
        'quote': 'O importante é resolver os problemas do povo.'
      },
    ];

    return CarouselSlider.builder(
      itemCount: adagesAngolais.length,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      itemBuilder: (context, index, realIdx) {
        final adage = adagesAngolais[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"${adage['quote']}"',
                style:  GoogleFonts.poppins(
                  fontSize: 20,
                  color: const Color(0xFF000000),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '- ${adage['author']}',
                style:  GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
