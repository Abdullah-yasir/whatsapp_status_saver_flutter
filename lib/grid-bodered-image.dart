import 'dart:io';

import 'package:flutter/material.dart';

class GridBorderedImage extends StatelessWidget {
  final String source;

  final GestureTapCallback onTap;

  const GridBorderedImage(
      {super.key, required this.source, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey.shade300),
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          clipBehavior: Clip.hardEdge,
          child: Image.file(
            File(source),
          ),
        ),
      ),
    );
  }
}
