import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/controller/utils/loading_indicator.dart';
import 'package:quran_app/controller/utils/themedata.dart';
import 'package:quran_app/l10n/app_localizations.dart';

import 'package:radio_player/radio_player.dart';

import '../../controller/controllers/app_controller.dart';
import '../../controller/controllers/radio_controller.dart';

class RadioScreen extends StatefulWidget {
  static const String routeName = "radio-screen";

  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  bool isPlaying = false;
  List<String>? metadata; // keep if needed later

  late Future<RadioResponse> radioStations;

  // index of current station in the list (instance-level)
  int index = 0;

  StreamSubscription<dynamic>? _playbackSub;
  String arabicRadio = "https://api.mp3quran.net/radios/radio_arabic.json";
  String englishRadio = "https://api.mp3quran.net/radios/radio_english.json";
  @override
  void initState() {
    super.initState();
    play();
  }

  @override
  void dispose() {
    _playbackSub?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initialize radioStations based on text direction once
    final TextDirection currentDirection = Directionality.of(context);
    final bool isLTR = currentDirection == TextDirection.ltr;
    radioStations = isLTR
        ? getRadioStations(englishRadio)
        : getRadioStations(arabicRadio);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.radio,
          style: const TextStyle(
            color: ThemeDataProvider.textDarkThemeColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: ThemeDataProvider.mainAppColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: MediaQuery.of(context).size.width > 1000
                ? provider.isDarkTheme()
                      ? const AssetImage(
                          ThemeDataProvider.imageBackgroundDarkWeb,
                        )
                      : const AssetImage(
                          ThemeDataProvider.imageBackgroundLightWeb,
                        )
                : provider.isDarkTheme()
                ? const AssetImage(ThemeDataProvider.imageBackgroundDark)
                : const AssetImage(ThemeDataProvider.imageBackgroundLight),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: FutureBuilder<RadioResponse>(
                  future: radioStations,
                  builder: (context, stations) {
                    if (stations.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            AppLocalizations.of(context)!.radio,
                            style: TextStyle(
                              color: provider.isDarkTheme()
                                  ? ThemeDataProvider.textDarkThemeColor
                                  : ThemeDataProvider.textLightThemeColor,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Lottie.asset('assets/images/radio.json'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),

                          // Text(
                          //   convertUTF8(
                          //       stations.data!.radios.elementAt(index).name),
                          //   style: TextStyle(
                          //     color: provider.isDarkTheme()
                          //         ? ThemeDataProvider.textDarkThemeColor
                          //         : ThemeDataProvider.textLightThemeColor,
                          //     fontSize: 18,
                          //   ),
                          // ),
                          Text(
                            "الإذاعة العامة - اذاعة متنوعة لمختلف القراء",
                            style: TextStyle(
                              color: provider.isDarkTheme()
                                  ? ThemeDataProvider.textDarkThemeColor
                                  : ThemeDataProvider.textLightThemeColor,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 50),
                              // Expanded(
                              //   child: Transform(
                              //     transform:
                              //         Matrix4.rotationY(isLTR ? math.pi : 0),
                              //     alignment: AlignmentDirectional.center,
                              //     child: IconButton(
                              //       icon: Icon(
                              //         Icons.fast_forward_sharp,
                              //         size: 30,
                              //         color: provider.isDarkTheme()
                              //             ? ThemeDataProvider.textDarkThemeColor
                              //             : ThemeDataProvider.textLightThemeColor,
                              //       ),
                              //       onPressed: () {
                              //         next(
                              //           stations.data!.radios
                              //               .elementAt(index)
                              //               .radio_url,
                              //           stations.data!.radios.length,
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  minRadius: 20,
                                  backgroundColor:
                                      ThemeDataProvider.mainAppColor,
                                  child: IconButton(
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 30,
                                      color:
                                          ThemeDataProvider.textDarkThemeColor,
                                    ),
                                    onPressed: () {
                                      isPlaying
                                          ? RadioPlayer.pause()
                                          : RadioPlayer.play();
                                    },
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   child: Transform(
                              //     transform:
                              //         Matrix4.rotationY(isLTR ? math.pi : 0),
                              //     alignment: AlignmentDirectional.center,
                              //     child: IconButton(
                              //       icon: Icon(
                              //         Icons.fast_rewind,
                              //         size: 30,
                              //         color: provider.isDarkTheme()
                              //             ? ThemeDataProvider.textDarkThemeColor
                              //             : ThemeDataProvider.textLightThemeColor,
                              //       ),
                              //       onPressed: () {
                              //         previous(stations.data!.radios
                              //             .elementAt(index)
                              //             .radio_url);
                              //       },
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(width: 50),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    } else if (stations.hasError) {
                      return const Text("حصل خطأ ما في الاتصال بالانترنت");
                    }
                    return const LoadingIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void play() {
    // subscribe to playback state stream (static API)
    _playbackSub = RadioPlayer.playbackStateStream.listen((value) {
      setState(() {
        // PlaybackState.toString() usually contains 'playing' when active
        isPlaying = value.toString().toLowerCase().contains('playing');
      });
    });

    // set initial station using static API
    RadioPlayer.setStation(
      title: "Radio Quran",
      url: "https://Qurango.net/radio/mix",
      logoAssetPath: "assets/images/time.jpg",
    );
  }

  void next(String radioStation, int length) {
    if (index < length - 1) index++;
    RadioPlayer.setStation(
      title: "Radio Quran",
      url: radioStation,
      logoAssetPath: "assets/images/time.jpg",
    );

    setState(() {});
  }

  void previous(String radioStation) {
    if (index > 0) index--;
    RadioPlayer.setStation(
      title: "Radio Quran",
      url: radioStation,
      logoAssetPath: "assets/images/time.jpg",
    );
    setState(() {});
  }
}

String convertUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}
