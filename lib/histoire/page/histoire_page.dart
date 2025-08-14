import 'package:Kilumbu/const/appbar.dart';
import 'package:flutter/material.dart';

class HistoirePage extends StatelessWidget {
  const HistoirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Kilumbu',
        subtitle: 'história',
        actionIcon: Icons.history_edu_outlined,
        onActionPressed: null,
        logoAssetPath: 'assets/images/logo/ao-06.png',
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Esta seção da história estará disponível em breve em português.',
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
