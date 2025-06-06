import 'dart:ui';

import 'package:Kilumbu/const/appbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
        subtitle: 'Explore a Cultura Angolana',
        actionIcon: Icons.help_outline,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🖼 Image en-tête avec flou et texte
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/angola.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(color: Colors.black.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Angola Avante',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Adoptado em 1975, após a independência de Portugal.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                    style: const TextStyle(fontSize: 14, height: 1.6),
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
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      label: Text(isPlaying ? 'Pause' : 'Ovir l\'Hino'),
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
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Bachar PDF'),
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '✍️ Letra: Manuel Rui Monteiro\n🎵 Música: Rui Mingas',
                  style: TextStyle(
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
