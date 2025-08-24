import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran_app/controller/utils/themedata.dart';
import 'package:quran_app/view/landing_screen.dart';


// ignore: camel_case_types
class onBoardingPage extends StatelessWidget {
  static const String routeName = "onBoarding-screen";

  const onBoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "'إِنَّ هَذَا الْقُرْآنَ يَهْدِي لِلَّتِي هِيَ أَقْوَمُ'",
          body:
             'القرآن هو هداية ونور يوجهك إلى الطريق المستقيم في حياتك اليومية',
          image: buildImage('assets/images/onBoarding_quran.jpg'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title: "'إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَوْقُوتًا'",
          body: 'التطبيق يساعدك على المحافظة على صلواتك في أوقاتها بكل سهولة',
          image: buildImage('assets/images/prayer.jpg'),
          decoration: buildDecoration(),
        ),
        PageViewModel(
          title:
              "'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ'",
          body:
             'الأذكار والتسبيح تقوي صلتك بالله وتمنحك راحة وطمأنينة',
          image: buildImage('assets/images/zekr.jpg'),
          decoration: buildDecoration(),
        ),
      ],
      next: const Icon(
        Icons.navigate_before,
        size: 40,
        color: ThemeDataProvider.mainAppColor,
      ),
      done: const Text('Done',
          style:
              TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(color: ThemeDataProvider.mainAppColor, fontSize: 20),
      ),
      onSkip: () => goToHome(context),
      dotsDecorator: getDotDecoration(),
      animationDuration: 1000,
      globalBackgroundColor: Colors.white,
      rtl: true,
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.grey,
      size: const Size(10, 10),
      activeColor: ThemeDataProvider.mainAppColor,
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  void goToHome(BuildContext context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LandingScreen()));

  Widget buildImage(String path) => Center(child: Image.asset(path));

  PageDecoration buildDecoration() => const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: "quranFont",
            color: ThemeDataProvider.mainAppColor),
        bodyTextStyle: TextStyle(
          fontSize: 20,
          fontFamily: "quranFont",
        ),
        bodyAlignment: Alignment.bottomCenter,
        imageAlignment: Alignment.bottomCenter,
        pageColor: Colors.white,
        imagePadding: EdgeInsets.only(
          top: 50,
          left: 10,
          right: 10,
        ),
      );
}
