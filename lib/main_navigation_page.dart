import 'package:Kilumbu/home.dart';
import 'package:Kilumbu/mais/page/maispage.dart';
import 'package:Kilumbu/president/page/president_page.dart';
import 'package:Kilumbu/province/page/provinces_page.dart';
import 'package:flutter/material.dart';


import 'const/bottombar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const ProvincesPage();
      case 2:
        return  const PresidentPage();
      case 3:
        return  const MaisPage();
    // Ajoute ici d'autres pages plus tard
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_currentIndex),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
