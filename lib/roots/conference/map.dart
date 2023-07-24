import 'package:app/models/conference.dart';
import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, required this.conference});

  final Conference conference;

  @override
  build(context) {
    return const SelectableText("map");
  }
}