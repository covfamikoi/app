import 'package:app/models/conference.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  final Conference conference;

  const CalendarView({super.key, required this.conference});

  @override
  build(context) {
    return const SelectableText("Calendar");
  }
}