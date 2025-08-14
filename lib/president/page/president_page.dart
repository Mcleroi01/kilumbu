import 'dart:ui';
import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/president/model/president.dart';
import 'package:Kilumbu/president/page/president_detail_page.dart';
import 'package:Kilumbu/president/service/president_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PresidentPage extends StatefulWidget {
  const PresidentPage({super.key});

  @override
  State<PresidentPage> createState() => _PresidentPageState();
}

class _PresidentPageState extends State<PresidentPage> {
  final PresidentService _presidentService = PresidentService();
  List<President> _presidents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPresidents();
  }

  Future<void> _loadPresidents() async {
    try {
      final result = await _presidentService.getAllPresidents();
      setState(() {
        _presidents = result;
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur : $e');
      setState(() => _isLoading = false);
      // Tu peux aussi afficher une alerte si tu veux
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.info_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔝 Bannière
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Presidentes de Angola',
              subtitle: 'Descubra os líderes históricos que moldaram o país.',
            ),

            const SizedBox(height: 20),

            // 🧑‍🏫 Liste des Présidents en grille
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _presidents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmall ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final president = _presidents[index];
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
            Image.network(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey),
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
                style: GoogleFonts.poppins(
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
