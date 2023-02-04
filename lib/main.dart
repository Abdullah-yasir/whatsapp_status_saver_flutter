import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/classes/routes.dart';
import 'package:whatsapps_status_saver/screens/coming-soon-screen.dart';
import 'package:whatsapps_status_saver/screens/gallery-view-screen.dart';
import 'package:whatsapps_status_saver/screens/home-screen.dart';
import 'package:whatsapps_status_saver/screens/save-status-screen.dart';
import 'package:whatsapps_status_saver/screens/stickers-screen.dart';
import 'package:whatsapps_status_saver/screens/video-player-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        RoutesNames.home: (context) => const MyHomePage(title: 'Whats Status'),
        RoutesNames.quotes: (context) => const ComingSoonScreen(),
        RoutesNames.gallery: (context) => const ComingSoonScreen(),
        RoutesNames.stickers: (context) => const StickersScreen(),
        RoutesNames.saveStatus: (context) => const SaveStatusScreen(),
        RoutesNames.writeStatus: (context) => const ComingSoonScreen(),
        RoutesNames.videoPlayer: (context) => const VideoPlayerScreen(),
        RoutesNames.galleryView: (context) => const GalleryView(),
        RoutesNames.writeMessage: (context) => const ComingSoonScreen(),
      },
    );
  }
}
