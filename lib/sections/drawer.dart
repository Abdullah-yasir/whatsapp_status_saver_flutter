import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _saveStatus = false;
  final Color _iconColor = Colors.green.shade500;

  void _toggleSaveStatus(value) {
    setState(() {
      _saveStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Icon(
              Icons.whatsapp,
              size: 100,
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              size: 30,
              color: _iconColor,
            ),
            title: const Text("Instructions"),
            subtitle: const Text("How to use the App"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.save,
              size: 30,
              color: _iconColor,
            ),
            trailing: Switch(
              // This bool value toggles the switch.
              value: _saveStatus,
              activeColor: Colors.green,
              onChanged: (bool value) {
                _toggleSaveStatus(value);
              },
            ),
            title: const Text("Auto save status"),
            subtitle: const Text("Automatically save all seen statuses"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.supervised_user_circle,
              size: 30,
              color: _iconColor,
            ),
            title: const Text("Privacy Policy"),
            subtitle: const Text("How do we handle your data"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
