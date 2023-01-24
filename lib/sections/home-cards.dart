import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/classes/helpers.dart';
import 'package:whatsapps_status_saver/classes/routes.dart';
import 'package:whatsapps_status_saver/classes/screen-args.dart';
import 'package:whatsapps_status_saver/widgets/flex-card.dart';

class HomeCards extends StatefulWidget {
  const HomeCards({Key? key}) : super(key: key);

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  @override
  void initState() {
    (() async {
      await Helper.getStoragePermission();
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                FlexCard(
                  color: Colors.green,
                  icon: Icons.download,
                  text: 'Save',
                  description: 'Save the seen status images and videos',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesNames.saveStatus,
                      arguments:
                          ScreenArgs(dirPath: '', filePath: '', activeTab: 0),
                    );
                  },
                ),
                FlexCard(
                  color: Colors.green,
                  icon: Icons.image,
                  text: 'Gallery',
                  description: "Manage the WhatsApp media",
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.gallery);
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                FlexCard(
                  color: Colors.green,
                  icon: Icons.sticky_note_2,
                  text: 'Stickers',
                  description: "Save you favorite stickers",
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.stickers);
                  },
                ),
                FlexCard(
                  color: Colors.green,
                  icon: Icons.video_file_rounded,
                  text: 'Video',
                  description: "Split video file for status",
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.splitVideo);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                FlexCard(
                  color: Colors.green,
                  icon: Icons.circle_outlined,
                  text: 'Status',
                  description: "Write status with formatting",
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.writeStatus);
                  },
                ),
                FlexCard(
                  color: Colors.green,
                  icon: Icons.message,
                  text: 'Message',
                  description: "Write message with formatting",
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.writeMessage);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
