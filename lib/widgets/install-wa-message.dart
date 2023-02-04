import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WAInstallMessage extends StatelessWidget {
  const WAInstallMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Look's like WhatsApp isn't installed in your phone"),
        const SizedBox(height: 10),
        MaterialButton(
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Install WhatsApp'),
          onPressed: () {
            StoreRedirect.redirect(androidAppId: 'com.whatsapp');
          },
        )
      ],
    );
  }
}
