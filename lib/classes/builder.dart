import 'dart:io';

import 'package:flutter/material.dart';

class XBuilder {
  static Widget buildGrid({builder, itemsCount}) {
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
}
