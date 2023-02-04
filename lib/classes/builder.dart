import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/widgets/install-wa-message.dart';
import 'package:whatsapps_status_saver/widgets/spinner.dart';

class XBuilder {
  static Widget buildGrid({builder, itemsCount}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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

  static Widget buildPhotoItem(String path,
      {bool showBorder = false, Icon? centerIcon}) {
    BoxDecoration dec = const BoxDecoration();
    Widget downloadIcon = Container();

    if (showBorder) {
      dec = BoxDecoration(
        border: Border.all(color: Colors.blue, width: 1),
      );
      downloadIcon = Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
            ),
          ),
          width: 25,
          height: 25,
          child: const Icon(
            Icons.download_done,
            color: Colors.white,
            size: 18,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: dec,
            child: FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: Image.file(
                File(path),
              ),
            ),
          ),
        ),
        downloadIcon,
        Positioned.fill(
            child: Center(
          child: centerIcon,
        ))
      ],
    );
  }

  static void showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
          ],
        ),
      ),
    );
  }

  static getPresenter(bool showInstallWhatsApp, bool loading, bool isEmpty) =>
      ({
        required Widget child,
        String loadingText = "loading...",
        String emptyText = "Nothing found!",
      }) {
        if (showInstallWhatsApp) return const WAInstallMessage();

        if (loading) return Spinner(text: loadingText);

        if (isEmpty) return Center(child: Text(emptyText));

        return child;
      };
}
