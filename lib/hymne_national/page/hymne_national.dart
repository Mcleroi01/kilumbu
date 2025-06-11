import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:Kilumbu/const/custom_banner.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter/services.dart';

class HymneNationalPage extends StatefulWidget {
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
              subtitle: 'Antes da independência, a canção "Angola é Nossa" era utilizada, principalmente pelos portugueses em Angola, como um hino colonial não oficial, mas após o início das negociações de independência já não estava mais em uso.',
            ),

            const SizedBox(height: 8),

            // 🎼 Hymne complet
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
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
                    style:  GoogleFonts.poppins(fontSize: 14, height: 1.6),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Boutons audio et PDF
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _toggleAudio,
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,),
                      label: Text(isPlaying ? 'Pause' : 'Ovir l\'Hino',style: GoogleFonts.poppins(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openPdf,
                      icon: const Icon(Icons.picture_as_pdf,color: Colors.black,),
                      label:  Text('Bachar PDF',style: GoogleFonts.poppins(color:Colors.black ),),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✍️ Auteurs
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '✍️ Letra: Manuel Rui Monteiro\n🎵 Música: Rui Mingas',
                  style: GoogleFonts.poppins(
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontSize: 13,
                  ),
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
