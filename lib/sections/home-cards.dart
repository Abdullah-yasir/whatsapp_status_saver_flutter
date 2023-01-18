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
                  text: 'Save Status',
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
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.stickers);
                  },
                ),
                FlexCard(
                  color: Colors.green,
                  icon: Icons.format_quote_rounded,
                  text: 'Quotes',
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.quotes);
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
                  text: 'Write Status',
                  onTap: () {
                    Navigator.pushNamed(context, RoutesNames.writeStatus);
                  },
                ),
                FlexCard(
                  color: Colors.green,
                  icon: Icons.message,
                  text: 'Write Message',
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
