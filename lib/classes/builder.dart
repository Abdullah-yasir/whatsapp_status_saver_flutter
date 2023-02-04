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

  static Widget buildPhotoItem(String path) {
    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        File(path),
      ),
    );
  }

  static Widget buildVideoItem(String path) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.file(File(path)).image, fit: BoxFit.cover),
      ),
      child: const Center(
        child: Icon(
          Icons.play_circle_filled_rounded,
          color: Colors.green,
        ),
      ),
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
