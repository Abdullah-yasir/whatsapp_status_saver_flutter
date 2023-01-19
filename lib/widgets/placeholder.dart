import 'package:flutter/material.dart';

class XPlaceholder extends StatelessWidget {
  const XPlaceholder({super.key, this.text = "No Content"});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
