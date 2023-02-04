import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapps_status_saver/classes/routes.dart';
import 'package:whatsapps_status_saver/classes/screen-args.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    ScreenArgs args = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.share),
            ),
            onTap: () async {
              Share.shareXFiles([XFile(args.filePath)]);
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: const Text('Copy'), onTap: () {}),
              PopupMenuItem(
                  child: const Text('Delete'),
                  onTap: () async {
                    await File(args.filePath).delete();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, args.filePath);
                  }),
            ],
          ),
        ],
      ),
      body: PhotoView(
        minScale: 0.2,
        maxScale: 2.0,
        imageProvider: FileImage(
          File(args.filePath),
        ),
      ),
    );
  }
}
