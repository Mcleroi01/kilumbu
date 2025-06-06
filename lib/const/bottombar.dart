import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFFDD1C1A),
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Casa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Províncias',
        ),



        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: 'Presidente',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          label: 'Mais',
        ),
      ],
    );
  }
}
