import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/classes/builder.dart';
import 'package:whatsapps_status_saver/classes/constants.dart';
import 'package:whatsapps_status_saver/classes/file-formats.dart';
import 'package:whatsapps_status_saver/classes/helpers.dart';
import 'package:whatsapps_status_saver/classes/routes.dart';
import 'package:whatsapps_status_saver/classes/screen-args.dart';

class SaveStatusScreen extends StatefulWidget {
  const SaveStatusScreen({super.key});

  @override
  State<SaveStatusScreen> createState() => _SaveStatusScreenState();
}

class _SaveStatusScreenState extends State<SaveStatusScreen> {
  int activeTab = 0;
  bool loading = true;
  bool showInstallWhatsApp = false;

  late List<Directory> appDirectories;

  var photos = <String>[];
  var saved = <String>[];
  var statusVideos = <String>[];
  var statusVideosThumbs = <String>[];

  var savedVideoThumbMap = <String, String>{};

  void _downloadStatus(String filePath) async {
    // copying file to the save location
    File copiedFile = await Helper.copyFile(filePath, appDirectories[0].path);

    // if the file is a video, generate its thumbnail
    if (copiedFile.path.endsWith(Ext.video)) {
      savedVideoThumbMap[copiedFile.path] =
          await Helper.getVideoThumb(copiedFile);
    }

    setState(() {
      saved.add(copiedFile.path);
    });

    // ignore: use_build_context_synchronously
    XBuilder.showSnackBar("Status downloaded!", context);
  }

  Widget _buildSavedItem(String path) {
    if (path.endsWith(Ext.video) && savedVideoThumbMap.containsKey(path)) {
      return XBuilder.buildPhotoItem(
        savedVideoThumbMap[path] as String,
        centerIcon: const Icon(
          Icons.play_circle_filled_rounded,
          color: Colors.green,
        ),
      );
    }

    return XBuilder.buildPhotoItem(path);
  }

  void _onTapGridItem(String filePath) async {
    String routeName = RoutesNames.galleryView;

    if (filePath.endsWith(Ext.video)) routeName = RoutesNames.videoPlayer;

    // if user deletes any file, we get uri of it
    var deletedFile = await Navigator.pushNamed(
      context,
      routeName,
      arguments: ScreenArgs(
        dirPath: appDirectories[0].path,
        filePath: filePath,
      ),
    );

    if (deletedFile != null) {
      setState(() {
        saved.remove(deletedFile);
      });
    }
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

      // check if whatsApp dir exists
      if (Directory(Constants.statusFolder).existsSync()) {
        // read photos for FS
        photos = Helper.getPathsOfFiles(
            await Helper.getFilesOfType(Constants.statusFolder, Ext.image));

        // read items from save dir
        saved = Helper.getPathsOfFiles(
            await Helper.getFilesOfType(appDirectories[0].path, Ext.image));

        // read videos from WA FS
        statusVideos = Helper.getPathsOfFiles(
            await Helper.getFilesOfType(Constants.statusFolder, Ext.video));

        // get thumbs of all videos
        statusVideosThumbs = await Helper.getVideoThumbsPathList(statusVideos);

        // read saved videos from app's FS
        List<String> savedVideos = Helper.getPathsOfFiles(
            await Helper.getFilesOfType(appDirectories[0].path, Ext.video));

        saved.addAll(savedVideos);

        // get thumbs of saved videos
        for (String video in savedVideos) {
          savedVideoThumbMap[video] = await Helper.getVideoThumb(File(video));
        }
      } else {
        showInstallWhatsApp = true;
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
        body: TabBarView(
          children: [
            XBuilder.getPresenter(showInstallWhatsApp, loading, photos.isEmpty)(
                child: XBuilder.buildGrid(
                  itemsCount: photos.length,
                  builder: (context, index) {
                    bool isDownloaded = Helper.listContains(
                      saved,
                      photos[index].split(Platform.pathSeparator).last,
                    );
                    return GestureDetector(
                      child: XBuilder.buildPhotoItem(
                        photos[index],
                        showBorder: isDownloaded,
                      ),
                      onTap: () {
                        if (!isDownloaded) {
                          _downloadStatus(photos[index]);
                        } else {
                          Navigator.pushNamed(
                            context,
                            RoutesNames.galleryView,
                            arguments: ScreenArgs(
                              dirPath: appDirectories[0].path,
                              filePath: photos[index],
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                loadingText: "Getting WhatsApp Statuses...",
                emptyText: "No Status found"),
            XBuilder.getPresenter(
                    showInstallWhatsApp, loading, statusVideos.isEmpty)(
                child: XBuilder.buildGrid(
                  itemsCount: statusVideos.length,
                  builder: (context, index) {
                    bool isDownloaded = Helper.listContains(
                      saved,
                      statusVideos[index].split(Platform.pathSeparator).last,
                    );
                    return GestureDetector(
                      child: XBuilder.buildPhotoItem(statusVideosThumbs[index],
                          showBorder: isDownloaded,
                          centerIcon: const Icon(
                            Icons.play_circle_filled_rounded,
                            color: Colors.blue,
                          )),
                      onTap: () {
                        if (!isDownloaded) {
                          _downloadStatus(statusVideos[index]);
                        } else {
                          // open video
                          Navigator.pushNamed(
                            context,
                            RoutesNames.videoPlayer,
                            arguments: ScreenArgs(
                              dirPath: appDirectories[0].path,
                              filePath: statusVideos[index],
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                loadingText: "Getting Video Statuses...",
                emptyText: "No video found!"),
            XBuilder.getPresenter(showInstallWhatsApp, loading, saved.isEmpty)(
                child: XBuilder.buildGrid(
                  itemsCount: saved.length,
                  builder: (context, index) {
                    return GestureDetector(
                      child: _buildSavedItem(saved[index]),
                      onTap: () => _onTapGridItem(saved[index]),
                    );
                  },
                ),
                loadingText: "Loading Saved Statuses...",
                emptyText: "You haven't saved any status yet!"),
          ],
        ),
      ),
    );
  }
}
