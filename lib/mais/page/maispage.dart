import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaisPage extends StatelessWidget {
  const MaisPage({super.key});

  void _showModalSobre(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Sobre o aplicativo',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kilumbu - v1.0.0',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Kilumbu é um aplicativo educativo e cultural dedicado à divulgação da cultura angolana — incluindo história, províncias, línguas e património natural.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'Desenvolvido por',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/dev.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carlo Musongela',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Desenvolvedor Flutter & Web Fullstack',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Fechar',
              style: GoogleFonts.poppins(
                color: Colors.redAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }



  void _showModalAvaliar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Avaliar o aplicativo'),
        content: const Text(
          'Gostou do Kilumbu? Avalie-nos na loja e compartilhe com os seus amigos!',
        ),
        actions: [
          TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _showModalTermos(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Termos de uso'),
        content: const SingleChildScrollView(
          child: Text(
            'Ao usar este aplicativo, você concorda com os termos e condições definidos para o uso responsável das informações aqui apresentadas.',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _showModalPolitica(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Política de privacidade'),
        content: const SingleChildScrollView(
          child: Text(
            'O Kilumbu respeita sua privacidade. Nenhuma informação pessoal é coletada sem o seu consentimento.',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _showModalDireitos(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Direitos autorais'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/dev.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              '© 2025 Carlo Musongela',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Todos os direitos reservados.\nFeito com orgulho em Angola 🇦🇴',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Fechar'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }


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
            child: const Column(
              children: [
                SectionTile(
                  icon: Icons.location_on_outlined,
                  title: 'Locais turísticos',
                  description: 'Descubra pontos de interesse em Angola',
                ),
                Divider(height: 1, thickness: 0.5, indent: 16, endIndent: 16),
                SectionTile(
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
                SectionTile(
                  icon: Icons.info_outline,
                  title: 'Sobre o aplicativo',
                  description: 'Detalhes sobre o app e sua função',
                  onClick: () => _showModalSobre(context),
                ),

                SectionTile(
                  icon: Icons.star_border,
                  title: 'Avaliar o aplicativo',
                  description: 'Deixe a sua opinião na loja',
                  onClick: () => _showModalAvaliar(context),

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
                SectionTile(
                  icon: Icons.gavel_outlined,
                  title: 'Termos de uso',
                  description: 'Regras e condições do app',
                  onClick: () => _showModalTermos(context),
                ),
                SectionTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Política de privacidade',
                  description: 'Como os seus dados são usados',
                  onClick: () => _showModalPolitica(context),
                ),
                SectionTile(
                  icon: Icons.copyright_outlined,
                  title: 'Direitos autorais',
                  description: '© Mcleroi01',
                  onClick: () => _showModalDireitos(context),
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
  final VoidCallback? onClick;

  const SectionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onClick,
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
      onTap: onClick,
    );
  }





}
