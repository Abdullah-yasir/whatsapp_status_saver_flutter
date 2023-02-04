import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapps_status_saver/classes/screen-args.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ScreenArgs args;

  bool showPlayPauseButton = true;

  void onTapVideo() {
    setState(() {
      showPlayPauseButton = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (_controller.value.isPlaying) {
        setState(() {
          showPlayPauseButton = false;
        });
      }
    });
  }

  void onTapPlayButton() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();

      if (_controller.value.isPlaying) {
        showPlayPauseButton = false;
      } else {
        showPlayPauseButton = true;
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    _controller = VideoPlayerController.file(File(args.filePath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Video"),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.share),
            ),
            onTap: () {
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
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: GestureDetector(
                      onTap: onTapVideo,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: showPlayPauseButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: GestureDetector(
                    onTap: onTapPlayButton,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.9),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
