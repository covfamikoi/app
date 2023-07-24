import 'package:app/models/conference.dart';
import 'package:app/models/conference_public.dart';
import 'package:app/roots/conference/conference.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  List<PublicConference>? conferences;
  String? password;

  void fetchData() async {
    var data = await PublicConference.get();
    setState(() {
      conferences = data;
    });
  }

  Future<Conference?> getConference(BuildContext context, PublicConference conf,
      {bool invalid = false}) async {
    var cached = Conference.cached(conf.id);
    if (cached != null) {
      return cached;
    }

    return showDialog(
        context: context,
        builder: (context) {
          bool invalidPassword = false;
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                      title: Text(conf.title),
                      content: TextField(
                          decoration: InputDecoration(
                              hintText: "Event password",
                              errorText: invalidPassword
                                  ? "Incorrect password"
                                  : null),
                          onChanged: (value) {
                            setState(() => invalidPassword = false);
                            password = value;
                          }),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              if (password != null) {
                                Conference.fetch(conf.id, password!)
                                    .then((conf) {
                                  if (context.mounted) {
                                    Navigator.pop(context, conf);
                                  }
                                }).catchError((err) {
                                  if (context.mounted && err == 401) {
                                    setState(() => invalidPassword = true);
                                  } else {
                                    throw err;
                                  }
                                });
                              }
                            },
                            child: const Text("Submit"))
                      ]));
        });
  }

  @override
  build(context) {
    Widget body;
    if (conferences == null) {
      fetchData();
      body = const Text("Loading...");
    } else {
      body = ListView(children: [
        for (var conf in conferences!)
          ListTile(
            onTap: () {
              getConference(context, conf).then((conf) {
                if (conf != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConferenceView(conference: conf)));
                }
              });
            },
            title: Text(conf.title),
          )
      ]);
    }

    return Scaffold(body: Center(child: body));
  }
}
