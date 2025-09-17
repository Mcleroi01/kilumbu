import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/province/page/province_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../service/province_service.dart';
import '../model/province.dart';

class ProvincesPage extends StatefulWidget {
  const ProvincesPage({super.key});

  @override
  State<ProvincesPage> createState() => _ProvincesPageState();
}

class _ProvincesPageState extends State<ProvincesPage> {
  final ProvinceService provinceService = ProvinceService();

  List<Province> provinces = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    try {
      final data = await provinceService.getAllProvinces();
      setState(() {
        provinces = data;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur de chargement des provinces: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao carregar províncias')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Províncias',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Províncias de Angola',
              subtitle:
              'Descubra as 18 províncias angolanas com as suas capitais, população e área.',
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(province.nom,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text('Capitais : ${province.capitale}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black54)),
                                Text('Área : ${province.superficie}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black54)),
                                Text('População : ${province.population}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              province.mapPath,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.map, size: 40, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
