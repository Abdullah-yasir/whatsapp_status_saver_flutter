import 'package:flutter/material.dart';

class FlexCard extends StatelessWidget {
  Color color;
  IconData icon;
  String text;
  String description;
  var onTap;

  FlexCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: const Color(0x8c16521e),
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(color: Colors.green, width: 5),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  height: 80,
                  width: 80,
                  child: Icon(
                    icon,
                    color: Colors.green,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
