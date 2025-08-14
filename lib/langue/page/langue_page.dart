import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:Kilumbu/langue/model/linguas_nacional.dart';
import 'package:Kilumbu/langue/page/langue_detail_page.dart';
import 'package:Kilumbu/langue/service/linguas_nacional_service.dart';
import 'package:flutter/material.dart';

class LanguePage extends StatefulWidget {
  @override
  State<LanguePage> createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  final LinguaNacionalService service = LinguaNacionalService();

  List<LinguaNacional> _lingua = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPresidents();
  }

  Future<void> _loadPresidents() async {
    try {
      final result = await service.getAllLinguas();
      setState(() {
        _lingua = result;
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
        subtitle: 'Línguas',
        actionIcon: Icons.language,
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
            // Bannière

            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Línguas de Angola',
              subtitle: 'O português é a língua oficial e língua franca de Angola, fazendo da nação a segunda maior comunidade lusoparlante do mundo (atrás somente do Brasil).',
            ),

            const SizedBox(height: 20),

            Text(
              "Angola reconhece várias línguas nacionais que refletem a riqueza cultural dos seus povos. "
                  "Essas línguas são faladas em diferentes regiões e desempenham um papel essencial na identidade e comunicação das comunidades.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Grille des langues
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _lingua.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isSmall ? 2 : 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final lingua = _lingua[index];
                return _themeCard(
                  context,
                  lingua.nome,
                  lingua.imageUrl,
                  LangueDetailPage(id: lingua.id),
                  isOficial: lingua.reconhecidaOficialmente,
                );

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeCard(BuildContext context, String title, String imagePath, Widget destinationPage, {bool isOficial = false}) {
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
            Image(
               image: NetworkImage(imagePath),

              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
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
            if (isOficial)
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Oficial',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

}
