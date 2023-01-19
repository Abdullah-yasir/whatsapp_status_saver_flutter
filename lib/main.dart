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
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        RoutesNames.home: (context) => const MyHomePage(title: 'Whats Status'),
        RoutesNames.saveStatus: (context) => const SaveStatusScreen(),
        RoutesNames.gallery: (context) => const ComingSoonScreen(),
        RoutesNames.stickers: (context) => const StickersScreen(),
        RoutesNames.quotes: (context) => const ComingSoonScreen(),
        RoutesNames.writeStatus: (context) => const ComingSoonScreen(),
        RoutesNames.writeMessage: (context) => const ComingSoonScreen(),
        RoutesNames.galleryView: (context) => const GalleryView(),
        RoutesNames.videoPlayer: (context) => const VideoPlayerScreen()
      },
    );
  }
}
