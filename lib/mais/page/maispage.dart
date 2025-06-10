import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaisPage extends StatelessWidget {
  const MaisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.eco_outlined,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        children: [

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SectionTile(
                  icon: Icons.location_on_outlined,
                  title: 'Locais turísticos',
                  description: 'Descubra pontos de interesse em Angola',
                ),
                const Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16),
                const SectionTile(
                  icon: Icons.event_note_outlined,
                  title: 'Eventos',
                  description: 'Veja o que está a acontecer perto de si',
                ),
              ],
            ),
          ),

          const Divider(height: 32),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SectionTile(
                  icon: Icons.info_outline,
                  title: 'Sobre o aplicativo',
                  description: 'Detalhes sobre o app e sua função',
                ),

                const SectionTile(
                  icon: Icons.star_border,
                  title: 'Avaliar o aplicativo',
                  description: 'Deixe a sua opinião na loja',
                ),
              ],
            ),
          ),


          const Divider(height: 32),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SectionTile(
                  icon: Icons.gavel_outlined,
                  title: 'Termos de uso',
                  description: 'Regras e condições do app',
                ),
                const SectionTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Política de privacidade',
                  description: 'Como os seus dados são usados',
                ),
                const SectionTile(
                  icon: Icons.copyright_outlined,
                  title: 'Direitos autorais',
                  description: '© Mcleroi01',
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

class SectionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SectionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFDD1C1A), size: 30),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        description,
        style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey.shade600),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      onTap: () {
        // Navigação ou ação
      },
    );
  }
}
