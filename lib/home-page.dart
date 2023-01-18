import 'package:flutter/material.dart';
import 'package:whatsapps_status_saver/drawer.dart';
import 'package:whatsapps_status_saver/home-cards.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.share),
            ),
          )
        ],
      ),
      body: const HomeCards(),
      drawer: const DrawerWidget(),
    );
  }
}
