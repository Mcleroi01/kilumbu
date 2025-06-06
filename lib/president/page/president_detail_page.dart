import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/data/president_data.dart';
import 'package:Kilumbu/president/model/president.dart';
import 'package:flutter/material.dart';

class PresidentDetailPage extends StatelessWidget {
  final int id;

  const PresidentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final President president =
    presidentAngolaises.firstWhere((p) => p.id == id);

    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Image de fond
          Positioned.fill(
            child: Image.asset(
              president.imagePath,
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
                  president.nom,
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
                        president.imagePath,
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
                          president.nom,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          president.profissao,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),


                        // Onglets
                        TabBar(
                          labelColor: const Color(0xFFDD1C1A),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: const Color(0xFFDD1C1A),
                          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                          tabs: const [
                            Tab(text: "Aperçu"),
                            Tab(text: "Détail"),
                            Tab(text: "Avis"),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Contenu des tabs
                        SizedBox(
                          height: 500, // adapte selon ta mise en page
                          child: TabBarView(
                            children: [
                              // Aperçu
                              Text(
                                president.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow(Icons.person, president.nom),
                                  _buildInfoRow(Icons.cake, president.dateNais),
                                  _buildInfoRow(Icons.flag, president.dateMandat),
                                  _buildInfoRow(Icons.work, president.profissao),
                                  _buildInfoRow(Icons.account_balance, president.partido),
                                  _buildInfoRow(Icons.self_improvement, president.religiao),

                                  const SizedBox(height: 16),

                                  SizedBox(
                                    height: 140,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: president.photos.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          margin: const EdgeInsets.only(right: 12),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              president.photos[index],
                                              width: 160,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),




                              // Avis
                              const Center(child: Text("Aucun avis pour le moment.")),
                            ],
                          ),
                        ),

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

  Widget _buildInfoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w100,
                fontSize: 13,
                color: Colors.grey,
                height: 1.4,),
            ),
          ),
        ],
      ),
    );
  }

}
