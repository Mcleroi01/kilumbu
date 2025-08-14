import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';

class FeriadosPage extends StatelessWidget {
  const FeriadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'Feriados',
        actionIcon: Icons.accessibility_new_sharp,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Esta seção estará disponível em breve em português.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
