import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/province/page/province_detail_page.dart';
import 'package:flutter/material.dart';
import '../service/province_service.dart';
import '../model/province.dart';
import 'dart:ui';

class ProvincesPage extends StatefulWidget {
  const ProvincesPage({Key? key}) : super(key: key);

  @override
  State<ProvincesPage> createState() => _ProvincesPageState();
}

class _ProvincesPageState extends State<ProvincesPage> {
  int currentIndex = 0;
  final ProvinceService provinceService = ProvinceService();

  @override
  Widget build(BuildContext context) {
    final List<Province> provinces = provinceService.getAllProvinces();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),

      body: Column(
        children: [
          // 🌄 Header d’intro
        Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/angola.jpg'), // 🖼️ Remplace avec ton image
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 💨 Flou sur l’image
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.black.withOpacity(0.3)), // assombrit
              ),

              // 📝 Texte au-dessus
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Províncias de Angola',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Descubra as 18 províncias angolanas com as suas capitais, população e área.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),

          const SizedBox(height: 12),

          // 📋 Liste des provinces
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: provinces.length,

              itemBuilder: (context, index) {
                final Province province = provinces[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProvinceDetailsPage(id: province.id),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16), // pour l'effet ripple arrondi
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Infos à gauche
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  province.nom,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text('capitais : ${province.capitale}',
                                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                Text('área : ${province.superficie}',
                                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
                                Text('população : ${province.population}',
                                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Image à droite
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              province.mapPath,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },
            ),
          ),
        ],
      ),



    );
  }
}
