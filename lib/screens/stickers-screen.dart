import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/classes/builder.dart';
import 'package:whatsapps_status_saver/classes/constants.dart';
import 'package:whatsapps_status_saver/classes/helpers.dart';
import 'package:whatsapps_status_saver/widgets/grid-bodered-image.dart';
import 'package:whatsapps_status_saver/widgets/grid-image.dart';
import 'package:whatsapps_status_saver/widgets/placeholder.dart';
import 'package:whatsapps_status_saver/widgets/spinner.dart';

class StickersScreen extends StatefulWidget {
  const StickersScreen({super.key});

  @override
  State<StickersScreen> createState() => _StickersScreenState();
}

class _StickersScreenState extends State<StickersScreen> {
  bool showInstallWhatsApp = false;
  bool loading = true;

  List<FileSystemEntity> stickers = [];
  List<FileSystemEntity> savedStickers = [];
  List<Directory> appDirectories = [];

  String stickerPath = Constants.stickersFolder;
  late String stickersSavePath;

  void _saveSticker(String path) async {
    File file = await Helper.copyFile(path, stickersSavePath);
    savedStickers.add(file);

    setState(() {});
    XBuilder.showSnackBar("Sticker saved!", context);
  }

  @override
  void initState() {
    (() async {
      appDirectories = await Helper.getAppDirectories();

      if (Directory(Constants.statusFolder).existsSync()) {
        String savePath = [
          appDirectories[0].parent.path,
          Platform.pathSeparator,
          'stickers'
        ].join();

        Directory savedStickersDir = Directory(savePath);

        // create dir for saving stickers if not exist
        if (!(await savedStickersDir.exists())) {
          await savedStickersDir.create();
        }

        stickersSavePath = savedStickersDir.path;

        stickers = await Helper.getFilesOfType(stickerPath, 'webp');
        savedStickers = await Helper.getFilesOfType(stickersSavePath, 'webp');

        setState(() {});
      } else {
        showInstallWhatsApp = true;
      }
      loading = false;
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
            XBuilder.getPresenter(
              showInstallWhatsApp,
              loading,
              stickers.isEmpty,
            )(
              child: XBuilder.buildGrid(
                builder: (context, index) {
                  return GridBorderedImage(
                    source: stickers[index].path,
                    onTap: () {
                      _saveSticker(stickers[index].path);
                    },
                  );
                },
                itemsCount: stickers.length,
              ),
              loadingText: "Getting stickers...",
              emptyText: "No stickers found!",
            ),
            savedStickers.isEmpty
                ? const XPlaceholder(
                    text: "You have not yet saved any sticker!")
                : XBuilder.buildGrid(
                    builder: (context, index) {
                      return GridImage(
                        source: savedStickers[index].path,
                        onTap: () {},
                      );
                    },
                    itemsCount: savedStickers.length,
                  ),
          ],
        ),
      ),
    );
  }
}
