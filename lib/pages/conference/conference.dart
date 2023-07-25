import 'package:app/components/admin_account.dart';
import 'package:app/models/conference.dart';
import 'package:app/pages/conference/calendar.dart';
import 'package:app/pages/conference/home.dart';
import 'package:app/pages/conference/map.dart';
import 'package:app/pages/conference/settings.dart';
import 'package:flutter/material.dart';

class ConferenceView extends StatefulWidget {
  const ConferenceView({super.key, required this.conference});

  final Conference conference;

  @override
  createState() => _ConferenceViewState();
}

class _ConferenceViewState extends State<ConferenceView> {
  int pageIndex = 0;

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.conference.title), centerTitle: false, actions: const [AdminAccountButton()]),
        body: switch (pageIndex) {
              0 => HomeView(conference: widget.conference),
              1 => CalendarView(conference: widget.conference),
              2 => MapView(conference: widget.conference),
              3 => SettingsView(conference: widget.conference),
              _ => const Text("unknown page"),
            },
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.brown.shade400),
            BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month),
                label: "Calendar",
                backgroundColor: Colors.red.shade300),
            BottomNavigationBarItem(
                icon: const Icon(Icons.map),
                label: "Map",
                backgroundColor: Colors.green.shade300),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Colors.blueGrey.shade600),
          ],
          onTap: (idx) => setState(() {
            pageIndex = idx;
          }),
          currentIndex: pageIndex,
        ));
  }
}
