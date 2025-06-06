import 'package:Kilumbu/province/page/province_detail_page.dart';
import 'package:Kilumbu/province/page/provinces_page.dart';
import 'package:flutter/material.dart';
import 'package:Kilumbu/home.dart';
import 'package:Kilumbu/main_navigation_page.dart';

class SabedoriaApp extends StatelessWidget {
  const SabedoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kilumbu',
      debugShowCheckedModeBanner: false,
      theme: sabedoriaTheme, // application du thème
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const MainNavigationPage(),
        '/provinces': (BuildContext context) => const ProvincesPage(),

      },
      builder: (context, child) {
        // Gestion du responsive globalement
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(mediaQuery.textScaleFactor.clamp(1.0, 1.2))),
          child: child!,
        );
      },
    );
  }
}

final ThemeData sabedoriaTheme = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFDFDFD),
  primaryColor: const Color(0xFF1D3557),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFE63946),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 14),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
);
