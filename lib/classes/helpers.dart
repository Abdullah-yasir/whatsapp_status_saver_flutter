import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Helper {
  static Future<File> copyFile(String fileUri, String copyTo) async {
    File fileToCopy = File(fileUri);
    // copy file from .Status folder
    List<String> path = [
      copyTo,
      Platform.pathSeparator,
      fileToCopy.path.split(Platform.pathSeparator).last
    ];
    return await fileToCopy.copy(path.join());
  }

  static Future<List<Directory>> getAppDirectories() async {
    List<Directory>? dirs = await getExternalStorageDirectories();
    if (dirs == null) return [];
    return dirs;
  }

  static Future<List<FileSystemEntity>> getFilesOfType(
      String source, String type) async {
    var result = <FileSystemEntity>[];
    var dirList = Directory(source).list(recursive: true, followLinks: false);

    await for (var entity in dirList) {
      if (entity.path.endsWith(type)) result.add(entity);
    }

    return result;
  }

  static Future<bool> getStoragePermission() async {
    return await Permission.storage.request().isGranted;
  }

  static Future<String> getVideoThumb(File file) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = await VideoThumbnail.thumbnailFile(
      video: file.path,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );

    if (fileName == null) return '';

    return fileName;
  }

  static Future<List<String>> getVideoThumbsPathList(List<String> videos) {
    final List<Future<String>> futures =
        videos.map((path) => getVideoThumb(File(path))).toList();

    return Future.wait(futures);
  }

  static Future<Directory> createDirectory(String path) async {
    return await Directory(path).create(recursive: true);
  }

  static List<String> getPathsOfFiles(List<FileSystemEntity> entities) {
    return entities.map((e) => e.path).toList();
  }

  static bool listContains(List<String> list, String item) {
    return list.any((element) => element.endsWith(item));
  }
}
