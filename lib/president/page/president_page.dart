import 'dart:ui';

import 'package:Kilumbu/capital/page/capital_page.dart';
import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/hero/page/hero_page.dart';
import 'package:Kilumbu/hymne_national/page/hymne_national.dart';
import 'package:Kilumbu/langue/page/langue_page.dart';
import 'package:Kilumbu/parque_naturel/page/parque_naturel.dart';
import 'package:Kilumbu/president/model/president.dart';
import 'package:Kilumbu/president/page/president_detail_page.dart';
import 'package:Kilumbu/president/service/president_service.dart';
import 'package:flutter/material.dart';

class PresidentPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PresidentPage();

}

class _PresidentPage extends State<PresidentPage>{
  final PresidentService presidentService = PresidentService();
  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    final List<President> presidents = presidentService.getAllPresident();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.info_outline,
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
                            'Presidentes de Angola',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Descubra os líderes históricos que moldaram o país.',
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

            // 🧑‍🏫 Liste des Présidents en grille
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: presidents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmall ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final president = presidents[index];
                return _themeCard(
                  context,
                  president.nom,
                  president.imagePath,
                  PresidentDetailPage(id: president.id),
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