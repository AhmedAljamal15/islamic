import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/utils/themedata.dart';
import 'package:quran_app/view/hadith/hadith_and_azkar.dart';
import 'package:quran_app/view/qibla/qibla.dart';
import 'package:quran_app/view/quran/quran_screen.dart';
import 'package:quran_app/view/radio/radio_screen.dart';
import 'package:quran_app/view/tasbeeh/tasbeeh_screen.dart';

import '../controller/controllers/app_controller.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = "landing-screen";

  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  List pages = [
    const QuranScreen(),
    const HadithAndAzkarScreen(),
    const TasbeehScreen(),
    const QiblaScreen(),
    const RadioScreen(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppController>(context);
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: provider.isDarkTheme()
            ? ThemeDataProvider.primaryDarkThemeColor
            : ThemeDataProvider.primaryLightThemeColor,
        selectedItemColor: ThemeDataProvider.mainAppColor,
        unselectedItemColor: provider.isDarkTheme()
            ? ThemeDataProvider.textDarkThemeColor
            : ThemeDataProvider.textLightThemeColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bookOpen), label: 'quran'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.scroll), label: 'hadeth'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.handsPraying), label: 'tasbeeh'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.kaaba), label: 'qiblah'),
          BottomNavigationBarItem(icon: Icon(Icons.radio), label: 'Radio'),
        ],
      ),
    );
  }
}
