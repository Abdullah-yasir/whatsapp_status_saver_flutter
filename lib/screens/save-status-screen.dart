import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/classes/builder.dart';
import 'package:whatsapps_status_saver/classes/constants.dart';
import 'package:whatsapps_status_saver/classes/file-formats.dart';
import 'package:whatsapps_status_saver/classes/helpers.dart';
import 'package:whatsapps_status_saver/classes/routes.dart';
import 'package:whatsapps_status_saver/classes/screen-args.dart';
import 'package:whatsapps_status_saver/widgets/spinner.dart';

class SaveStatusScreen extends StatefulWidget {
  const SaveStatusScreen({super.key});

  @override
  State<SaveStatusScreen> createState() => _SaveStatusScreenState();
}

class _SaveStatusScreenState extends State<SaveStatusScreen> {
  int activeTab = 0;
  bool loading = true;
  String whatsappStatusDir = Constants.statusFolder;

  late List<Directory> appDirectories;

  var photos = <String>[];
  var saved = <String>[];
  var statusVideos = <String>[];
  var statusVideosThumbs = <String>[];

  var savedVideoThumbMap = <String, String>{};

  void _downloadStatus(String filePath) async {
    // copying file to the save location
    File copiedFile = await Helper.copyFile(filePath, appDirectories[0].path);

    if (copiedFile.path.endsWith(Ext.video)) {
      savedVideoThumbMap[copiedFile.path] =
          await Helper.getVideoThumb(copiedFile);
    }

    // loading saved images in state
    List<String> images = Helper.getPathsOfFiles(
        await Helper.getFilesOfType(appDirectories[0].path, Ext.image));

    // loading saved videos in state
    List<String> videos = Helper.getPathsOfFiles(
        await Helper.getFilesOfType(appDirectories[0].path, Ext.video));

    images.addAll(videos);

    setState(() {
      saved = images;
    });

    XBuilder.showSnackBar("Status downloaded!", context);
  }

  Widget _buildSavedItem(String path) {
    if (path.endsWith(Ext.video) && savedVideoThumbMap.containsKey(path)) {
      return XBuilder.buildVideoItem(savedVideoThumbMap[path] as String);
    }

    return XBuilder.buildPhotoItem(path);
  }

  void _onTapGridItem(String filePath) {
    String routeName = RoutesNames.galleryView;

    if (filePath.endsWith(Ext.video)) routeName = RoutesNames.videoPlayer;

    Navigator.pushNamed(
      context,
      routeName,
      arguments: ScreenArgs(
        dirPath: appDirectories[0].path,
        filePath: filePath,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      activeTab =
          (ModalRoute.of(context)!.settings.arguments as ScreenArgs).activeTab;
    });
  }

  @override
  void initState() {
    (() async {
      appDirectories = await Helper.getAppDirectories();
      photos = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(whatsappStatusDir, Ext.image));

      saved = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(appDirectories[0].path, Ext.image));

      statusVideos = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(whatsappStatusDir, Ext.video));

      statusVideosThumbs = await Helper.getVideoThumbsPathList(statusVideos);

      List<String> savedVideos = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(appDirectories[0].path, Ext.video));

      saved.addAll(savedVideos);

      for (String video in savedVideos) {
        savedVideoThumbMap[video] = await Helper.getVideoThumb(File(video));
      }

      loading = false;
      setState(() {});
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: activeTab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Save Status"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.image),
                text: "Images",
              ),
              Tab(
                icon: Icon(Icons.video_collection),
                text: "Videos",
              ),
              Tab(
                icon: Icon(Icons.save),
                text: "Saved",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          loading
              ? Spinner()
              : XBuilder.buildGrid(
                  builder: (context, index) {
                    return GestureDetector(
                      child: XBuilder.buildPhotoItem(photos[index]),
                      onTap: () => _downloadStatus(photos[index]),
                    );
                  },
                  itemsCount: photos.length,
                ),
          loading
              ? Spinner()
              : XBuilder.buildGrid(
                  builder: (context, index) {
                    return GestureDetector(
                      child: XBuilder.buildVideoItem(statusVideosThumbs[index]),
                      onTap: () => _downloadStatus(statusVideos[index]),
                    );
                  },
                  itemsCount: statusVideos.length,
                ),
          loading
              ? Spinner()
              : XBuilder.buildGrid(
                  builder: (context, index) {
                    return GestureDetector(
                      child: _buildSavedItem(saved[index]),
                      onTap: () => _onTapGridItem(saved[index]),
                    );
                  },
                  itemsCount: saved.length,
                ),
        ]),
      ),
    );
  }
}
