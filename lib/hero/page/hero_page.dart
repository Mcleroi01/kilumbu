import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/data/heroi_nacionai_data.dart';
import 'package:Kilumbu/hero/model/heroi_nacional.dart';
import 'package:Kilumbu/hero/page/hero_nacional_detail_page.dart';
import 'package:Kilumbu/hero/service/heroi_nacioanal_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroPage extends StatefulWidget {
  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  final HeroiNacionalService heroiNacionalService = HeroiNacionalService();

  @override

  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final List<HeroiNacional> heros = heroiNacionalService.getHeroisNacionais();
    final List<HeroiNacional> heroisOficiais = heroiNacionalService.getHeroisOficiais();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Heróis Nacionais',
        actionIcon: Icons.star,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Heróis Nacionais de Angola',
              subtitle: 'Descubra as figuras históricas que marcaram a luta pela independência e o progresso do país.',
            ),
            const SizedBox(height: 20),

            Text(
              'Herói Nacional Reconhecido Oficialmente',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "A lista oficial dos heróis nacionais angolanos reconhecidos pelo Estado é limitada, sendo António Agostinho Neto o único oficialmente declarado como tal.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 16),

            if (heroisOficiais.length == 1)
              _themeCard(
                context,
                heroisOficiais[0].nome,
                heroisOficiais[0].imageUrl,
                HeroNacionalDetailPage(id: heroisOficiais[0].id),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: heroisOficiais.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isSmall ? 2 : 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final hero = heroisOficiais[index];
                  return _themeCard(
                    context,
                    hero.nome,
                    hero.imageUrl,
                    HeroNacionalDetailPage(id: hero.id),
                  );
                },
              ),


            const SizedBox(height: 30),

            Text(
              'Outras Figuras Reverenciadas',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Embora não oficialmente declarados heróis nacionais, diversas personalidades são amplamente reconhecidas por suas contribuições para a luta de libertação, paz e desenvolvimento de Angola.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 16),
            // 🧑‍🏫 Liste des Présidents en grille
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: heros.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmall ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final hero = heros[index];
                return _themeCard(
                  context,
                  hero.nome,
                  hero.imageUrl,
                  HeroNacionalDetailPage(id: hero.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeCard(BuildContext context, String title, String imagePath, Widget destinationPage, {double? width}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width ?? double.infinity,
        height: 260,
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
      ),
    );
  }

}
