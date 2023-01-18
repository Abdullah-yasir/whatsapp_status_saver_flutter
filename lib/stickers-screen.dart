import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/grid-bodered-image.dart';
import 'package:whatsapps_status_saver/grid-image.dart';
import 'package:whatsapps_status_saver/grid-view.dart';
import 'package:whatsapps_status_saver/helpers.dart';

class StickersScreen extends StatefulWidget {
  const StickersScreen({super.key});

  @override
  State<StickersScreen> createState() => _StickersScreenState();
}

class _StickersScreenState extends State<StickersScreen> {
  List<FileSystemEntity> stickers = [];
  List<Directory> appDirectories = [];
  String stickersDir =
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Stickers';

  Future<File> saveSticker(String path) async {
    String savePath = [
      appDirectories[0].parent.path,
      Platform.pathSeparator,
      'stickers'
    ].join();
    Directory savedStickers = await Helper.createDirectory(savePath);
    return await Helper.copyFile(path, savedStickers.path);
  }

  @override
  void initState() {
    (() async {
      stickers = await Helper.getFilesOfType(stickersDir, 'webp');
      appDirectories = await Helper.getAppDirectories();
      setState(() {});
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stickers"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.sticky_note_2),
                text: "All",
              ),
              Tab(
                icon: Icon(Icons.save),
                text: "Saved",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridViewCustom(
              builder: (context, index) {
                return GridBorderedImage(
                  source: stickers[index].path,
                  onTap: () {},
                );
              },
              itemsCount: stickers.length,
            ),
            GridViewCustom(
              builder: (context, index) {
                return GridImage(source: stickers[index].path, onTap: () {});
              },
              itemsCount: stickers.length,
            ),
          ],
        ),
      ),
    );
  }
}
