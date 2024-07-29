import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/playlist_screen.dart';
import 'package:music_app/screens/screens.dart';
import 'package:music_app/screens/song_screen.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          )
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/', page: ()=>HomeScreen()),
        GetPage(name: '/song', page: ()=>SongScreen()),
        GetPage(name: '/playlist', page: ()=>PlaylistScreen()),
        GetPage(name: '/screen', page: ()=>Screen())
      ],
    );
  }
}


