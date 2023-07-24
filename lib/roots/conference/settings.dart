import 'package:app/models/conference.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.conference});

  final Conference conference;

  @override
  build(context) {
    return const SelectableText("settings");
  }
}