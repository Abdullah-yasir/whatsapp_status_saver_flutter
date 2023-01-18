import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapps_status_saver/helpers.dart';
import 'package:whatsapps_status_saver/routes.dart';
import 'package:whatsapps_status_saver/screen-args.dart';

class SaveStatusScreen extends StatefulWidget {
  const SaveStatusScreen({super.key});

  @override
  State<SaveStatusScreen> createState() => _SaveStatusScreenState();
}

class _SaveStatusScreenState extends State<SaveStatusScreen> {
  int activeTab = 0;
  var photos = <String>[];
  var saved = <String>[];

  var statusVideos = <String>[];
  var statusVideosThumbs = <String>[];

  var savedVideoThumbMap = <String, String>{};

  late List<Directory> appDirectories;

  String whatsappStatusDir =
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';

  Widget _buildPhotoItem(String path) {
    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        File(path),
      ),
    );
  }

  Widget _buildVideoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.file(File(path)).image, fit: BoxFit.cover),
      ),
      child: const Center(
        child: Icon(
          Icons.play_circle_filled_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSavedItem(String path) {
    if (path.endsWith('mp4') && savedVideoThumbMap.containsKey(path)) {
      return _buildVideoItem(savedVideoThumbMap[path] as String);
    }

    return _buildPhotoItem(path);
  }

  Widget _buildGrid({builder, itemsCount}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: builder,
        itemCount: itemsCount,
      ),
    );
  }

  void _downloadStatus(String filePath) async {
    // copying file to the save location
    File copiedFile = await Helper.copyFile(filePath, appDirectories[0].path);

    if (copiedFile.path.endsWith('mp4')) {
      savedVideoThumbMap[copiedFile.path] =
          await Helper.getVideoThumb(copiedFile);
    }

    // loading saved images in state
    List<String> images = Helper.getPathsOfFiles(
        await Helper.getFilesOfType(appDirectories[0].path, 'jpg'));

    // loading saved videos in state
    List<String> videos = Helper.getPathsOfFiles(
        await Helper.getFilesOfType(appDirectories[0].path, 'mp4'));

    images.addAll(videos);

    setState(() {
      saved = images;
    });

    Fluttertoast.showToast(
        msg: "Status downloaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black45,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  void _onTapGridItem(String filePath) {
    String routeName = RoutesNames.galleryView;

    if (filePath.endsWith('mp4')) routeName = RoutesNames.videoPlayer;

    Navigator.pushNamed(
      context,
      routeName,
      arguments: ScreenArgs(
        dirPath: appDirectories[0].path,
        filePath: filePath,
      ),
    );
  }

  void _showDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: Column(
          children: [
            const Text(
                "Can't access device storage, the app need to access the storage to save the status"),
            Row(
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Give Permission"),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
              ],
            )
          ],
        ),
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
          await Helper.getFilesOfType(whatsappStatusDir, 'jpg'));

      saved = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(appDirectories[0].path, 'jpg'));

      statusVideos = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(whatsappStatusDir, 'mp4'));

      statusVideosThumbs = await Helper.getVideoThumbsPathList(statusVideos);

      List<String> savedVideos = Helper.getPathsOfFiles(
          await Helper.getFilesOfType(appDirectories[0].path, 'mp4'));

      saved.addAll(savedVideos);

      for (String video in savedVideos) {
        savedVideoThumbMap[video] = await Helper.getVideoThumb(File(video));
      }

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
          _buildGrid(
            builder: (context, index) {
              return GestureDetector(
                child: _buildPhotoItem(photos[index]),
                onTap: () => _downloadStatus(photos[index]),
              );
            },
            itemsCount: photos.length,
          ),
          _buildGrid(
            builder: (context, index) {
              return GestureDetector(
                child: _buildVideoItem(statusVideosThumbs[index]),
                onTap: () => _downloadStatus(statusVideos[index]),
              );
            },
            itemsCount: statusVideos.length,
          ),
          _buildGrid(
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
