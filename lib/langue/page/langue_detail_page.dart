import 'dart:ui';
import 'package:Kilumbu/const/info_tile.dart';
import 'package:Kilumbu/langue/model/linguas_nacional.dart';
import 'package:Kilumbu/langue/service/linguas_nacional_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class LangueDetailPage extends StatelessWidget {
  final int id;

  const LangueDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final LinguaNacionalService service = LinguaNacionalService();
    final LinguaNacional lingua = service.getLinguaNacionalById(id);

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond floue
          Positioned.fill(
            child: Image.asset(
              lingua.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),

          CustomScrollView(
            slivers: [
              // SliverAppBar avec image principale
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.white),
                title: Text(
                  lingua.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 6, color: Colors.black45)],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        lingua.imageUrl,
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
                        // Titre et infos principales
                        Text(
                          lingua.nome,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          lingua.region,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTile(icon:Icons.people, label: "falantes", value:"${lingua.locutores}"),
                            InfoTile(icon:Icons.language, label:"Família", value:lingua.familiaLinguistica),
                            InfoTile(icon:Icons.check_circle_outline,label: "Oficial", value:lingua.reconhecidaOficialmente ? "sim" : "nao"),
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
                            Tab(text: "Cultura"),
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
                                child: Text(
                                  lingua.descricao,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.4,
                                  ),
                                ),
                              ),

                              // 📋 Détails
                              SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoCard("🗺️ Région", lingua.region),
                                    _infoCard("👥 Nombre de locuteurs", "${lingua.locutores}"),
                                    _infoCard("🌐 Famille linguistique", lingua.familiaLinguistica),
                                    _infoCard("📜 Dialectes", lingua.dialectos.join(", ")),
                                    _infoCard("🔗 Cours / Ressources", lingua.urlAula),
                                  ],
                                ),
                              ),

                              // 🎭 Culture
                              SingleChildScrollView(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoCard("🎶 Usages culturels", lingua.usosCulturais.join(", ")),
                                    _infoCard("🛡️ Préservation", lingua.iniciativasPreservacao.join(", ")),
                                    _infoCard("💬 Exemples", lingua.exemplosFrases.join("\n")),
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

          // 🔘 Bouton flottant
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Explorar agora",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(lingua.urlAula); // Assure-toi que lingua.urlAula est une URL complète

                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication, // Ouvre dans le navigateur système
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Impossible d'ouvrir le lien")),
                        );
                      }
                    },

                      style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDD1C1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Aprender",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      )

    );
  }


  Future<void> _launchInUrl(Uri _monUrl) async {
    print(_monUrl);
    try {
      if (!await launchUrl(_monUrl)) {
        throw Exception('Could not launch $_monUrl');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// Affiche les infos capitale, superficie, climat, etc.
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
            Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(width: 4),

      ],
    );
  }

  /// Formate le texte en paragraphes stylisés
  List<InlineSpan> _buildArticleParagraphs(String text) {
    final paragraphs = text.trim().split('\n\n');

    return paragraphs.map((paragraph) {
      final firstLetter = paragraph.substring(0, 1);
      final rest = paragraph.substring(1);
      return TextSpan(
        children: [
          WidgetSpan(child: SizedBox(height: 16)),
          TextSpan(
            text: firstLetter,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          TextSpan(text: rest + '\n\n'),
        ],
      );
    }).toList();
  }
  Widget _infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
  _onPressed(){
    return null;
  }
}
