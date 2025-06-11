import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/province/page/province_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        subtitle: 'Províncias',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),

      body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),

        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomBanner(
            imagePath: 'assets/images/angola.jpg',
            title: 'Províncias de Angola',
            subtitle: 'Descubra as 18 províncias angolanas com as suas capitais, população e área.',
          ),

          const SizedBox(height: 12),

          // 📋 Liste des provinces
          SizedBox(
            height: 600, // or MediaQuery.of(context).size.height * 0.8
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
                  borderRadius: BorderRadius.circular(16),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(province.nom,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('capitais : ${province.capitale}',
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                                Text('área : ${province.superficie}',
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                                Text('população : ${province.population}',
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
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
          )

        ],
      ),
    )
    );
  }
}
