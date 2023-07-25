import 'package:flutter/material.dart';

class AdminAccountButton extends StatelessWidget {
  const AdminAccountButton({super.key});

  @override
  build(context) {
    return PopupMenuButton(
        icon: const Icon(Icons.account_circle),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(enabled: false, child: Text("Signed in as CircuitSacul")),
              const PopupMenuDivider(),
              const PopupMenuItem(child: Text("Change Password")),
              const PopupMenuDivider(),
              const PopupMenuItem(child: Text("Logout")),
              const PopupMenuItem(child: Text("Logout All Devices")),
            ]);
  }
}
