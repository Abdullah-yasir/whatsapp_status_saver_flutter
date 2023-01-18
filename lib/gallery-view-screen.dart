import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:whatsapps_status_saver/routes.dart';
import 'package:whatsapps_status_saver/screen-args.dart';

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
              child: Icon(Icons.delete),
            ),
            onTap: () {
              File(args.filePath).delete().then(
                    (value) => Navigator.pushNamed(
                      context,
                      RoutesNames.saveStatus,
                      arguments:
                          ScreenArgs(dirPath: '', filePath: '', activeTab: 2),
                    ),
                  );
            },
          )
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
