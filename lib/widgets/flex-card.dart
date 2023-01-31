import 'package:flutter/material.dart';

class FlexCard extends StatelessWidget {
  Color color;
  IconData icon;
  String text;
  String description;
  bool placeholder = false;
  var onTap;

  FlexCard({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.description,
    required this.onTap,
    this.placeholder = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = placeholder
        ? Container(
            color: const Color.fromARGB(0, 255, 255, 255),
            margin: const EdgeInsets.all(10.0),
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color(0x8c16521e),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        height: 60,
                        width: 60,
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
    return Expanded(child: content);
  }
}
