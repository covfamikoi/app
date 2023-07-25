import 'package:app/components/admin_account.dart';
import 'package:app/errors.dart';
import 'package:app/models/conference.dart';
import 'package:app/models/conference_public.dart';
import 'package:app/pages/conference/conference.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  List<PublicConference>? conferences;
  String? password;

  Future<void> fetchData() async {
    var data = await PublicConference.get().catchError((err) => throw processError(context, err));
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

    password = null;

    return showDialog(
        context: context,
        builder: (context) {
          bool invalidPassword = false;

          void onSubmit(
              BuildContext context, void Function(Function()) setState) {
            if (password != null) {
              Conference.fetch(conf.id, password!).then((conf) {
                if (context.mounted) {
                  Navigator.pop(context, conf);
                }
              }).catchError((err) {
                if (context.mounted) {
                  processError(context, err, allowPop: true);
                  if ([401, 403].contains(err)) {
                    setState(() => invalidPassword = true);
                  }
                }
              });
            }
          }

          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                      title: Text(conf.title),
                      content: TextField(
                          autofocus: true,
                          autocorrect: false,
                          onSubmitted: (_) => onSubmit(context, setState),
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
                            onPressed: () => onSubmit(context, setState),
                            child: const Text("Submit"))
                      ]));
        });
  }

  @override
  build(context) {
    List<ListTile> children;
    if (conferences == null) {
      fetchData();
      children = const [ListTile(title: Center(child: Text("Loading...")), enabled: false)];
    } else if (conferences!.isEmpty) {
      children = const [ListTile(title: Center(child: Text("No conferences.")), enabled: false)];
    } else {
      children = [
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
            trailing: const Icon(Icons.keyboard_arrow_right),
          )
      ];
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text("RP Events"),
            centerTitle: false,
            actions: const [AdminAccountButton()]),
        body: RefreshIndicator(
            onRefresh: fetchData, child: ListView(children: children)));
  }
}
