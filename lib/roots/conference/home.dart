import 'package:app/models/conference.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.conference});

  final Conference conference;

  @override
  build(context) {
    return const SelectableText("Home");
  }
}
