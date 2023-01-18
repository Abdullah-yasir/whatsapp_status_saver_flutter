import 'dart:io';

import 'package:flutter/material.dart';

class GridImage extends StatelessWidget {
  final String source;

  final GestureTapCallback onTap;

  const GridImage({super.key, required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: Image.file(
          File(source),
        ),
      ),
    );
  }
}
