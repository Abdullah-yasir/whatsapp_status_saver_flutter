import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewCustom extends StatefulWidget {
  final builder;

  final itemsCount;

  const GridViewCustom({super.key, this.builder, this.itemsCount});

  @override
  State<GridViewCustom> createState() => _GridViewCustom();
}

class _GridViewCustom extends State<GridViewCustom> {
  @override
  Widget build(BuildContext context) {
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
        itemBuilder: widget.builder,
        itemCount: widget.itemsCount,
      ),
    );
  }
}
