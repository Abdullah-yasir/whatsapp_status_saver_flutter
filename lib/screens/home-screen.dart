import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapps_status_saver/classes/constants.dart';
import 'package:whatsapps_status_saver/sections/drawer.dart';
import 'package:whatsapps_status_saver/sections/home-cards.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(
                  "*Whats Status & Sticker Saver*\nElevate your social media game with the ultimate WhatsApp status downloader!\nSay goodbye to screenshotting and hello to seamless saving.\n\nDownload our app now and never miss a beat of your friends' WhatsApp status updates:\n${Constants.playStoreUrl}\n\n#WhatsAppStatus #SneakPeek #NeverMissABeat",
                  subject: "Install Whats Status & Sticker Saver");
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.share),
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.linearToSrgbGamma(),
            fit: BoxFit.cover,
            image: AssetImage("assets/white-background.webp"),
          ),
        ),
        child: const HomeCards(),
      ),
      drawer: const DrawerWidget(),
    );
  }
}
