import 'dart:ui';
import 'package:Kilumbu/hero/model/heroi_nacional.dart';
import 'package:Kilumbu/hero/service/heroi_nacioanal_service.dart';
import 'package:flutter/material.dart';


class HeroNacionalDetailPage extends StatefulWidget {
  final int id;

  const HeroNacionalDetailPage({super.key, required this.id});

  @override
  State<HeroNacionalDetailPage> createState() => _HeroNacionalDetailPageState();
}


class _HeroNacionalDetailPageState extends State<HeroNacionalDetailPage> {
  final HeroiNacionalService _service = HeroiNacionalService();
  HeroiNacional? _heroi;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHeroi();
  }

  Future<void> _loadHeroi() async {
    try {
      final heroi = await _service.getHeroiById(widget.id);
      setState(() {
        _heroi = heroi;
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur : $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_heroi == null) {
      return const Scaffold(
        body: Center(child: Text("Héroi não encontrado")),
      );
    }

    final hero = _heroi!;

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.network(
              hero.imageUrl,
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
                  hero.nome,
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
                      Image.network(
                        hero.imageUrl,
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
                          hero.nome,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          hero.localNascimento,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),


                        // Onglets
                        const TabBar(
                          labelColor: Color(0xFFDD1C1A),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFFDD1C1A),
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          tabs: [
                            Tab(text: "Visão geral"),
                            Tab(text: "Detalhes"),
                            Tab(text: "Comentários"),
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
                                  hero.biografia,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w100,
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

                                    // Autres contenus si besoin
                                    const SizedBox(height: 24),
                                    // 📋 Informations en Card
                                    _infoCard("🧑‍🎓 Nome", hero.nome),
                                    _infoCard("📍 Local de Nascimento", hero.localNascimento),
                                    _infoCard("📅 Data de Nascimento", hero.dataNascimento),
                                    if (hero.dataFalecimento != null)
                                      _infoCard("🕯️ Data de Falecimento", hero.dataFalecimento!),
                                    _infoCard("📖 Contexto Histórico", hero.contexteHistorico),
                                    _infoCard("🏅 Contribuições", hero.contribuicoes.join(", ")),
                                    _infoCard("🗣️ Citações", hero.citations.join(" | ")),
                                    _infoCard("🎖️ Reconhecimento Oficial", hero.reconhecidoOficialmente ? "Sim" : "Não"),
                                    if (hero.dataReconhecimento != null)
                                      _infoCard("📆 Data de Reconhecimento", hero.dataReconhecimento!),
                                    _infoCard("🏛️ Homenagens", hero.hommages.join(", ")),

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


        ],
      ),
    );
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
          const WidgetSpan(child: SizedBox(height: 16)),
          TextSpan(
            text: firstLetter,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          TextSpan(text: '$rest\n\n'),
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
