import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';

class HymneNationalPage extends StatefulWidget {
  const HymneNationalPage({super.key});

  @override
  State<StatefulWidget> createState() => _HymneNationalPage();
}

class _HymneNationalPage extends State<HymneNationalPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  Future<void> _toggleAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('audio/hino_nacional.mp3'));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  Future<void> _openPdf() async {
    await OpenFilex.open('assets/files/hino_nacional.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Angola Avante',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomBanner(
              imagePath: 'assets/images/angola.jpg',
              title: 'Angola Avante',
              subtitle:
              'Antes da independência, a canção "Angola é Nossa" era usada como hino colonial não oficial, mas foi substituída após o início das negociações de independência.',
            ),

            const SizedBox(height: 20),

            // 🎼 Hymne complet
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '''
Oh pátria, nunca mais esqueceremos
Os heróis do quatro de Fevereiro.
Oh pátria, nós saudamos os teus filhos
Tombados pela nossa independência.

Honramos o passado e a nossa história
Construamos a nova vida,
De paz, justiça e progresso.

Cantemos a liberdade
Cantemos o povo soberano
Pela glória da pátria imortal.

Angola, avante!
Revolução pelo poder popular!
Pátria unida, liberdade,
Um só povo, uma só nação!

Levantemos nossas vozes
Cantemos o hino da liberdade,
Com radiantes vozes do povo,
Marchando para a vitória final.

Pátria unida, liberdade,
Um só povo, uma só nação!
''',
                    style: GoogleFonts.poppins(fontSize: 14, height: 1.6),

                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Boutons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _toggleAudio,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: Text(
                      isPlaying ? 'Pausar' : 'Ouvir o Hino',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openPdf,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.black),
                    label: Text(
                      'Baixar PDF',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ✍️ Auteurs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '✍️ Letra: Manuel Rui Monteiro\n🎵 Música: Rui Mingas',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
