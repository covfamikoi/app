import 'dart:convert';

import 'package:app/constants.dart';
import 'package:http/http.dart' as http;

class PublicConference {
  final int id;
  final String title;

  const PublicConference(this.id, this.title);

  PublicConference.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };

  static Future<List<PublicConference>> fetch() async {
    var ret = await http.read(buildUrl("api/conferences/list/public"));
    var data = jsonDecode(ret);
    return [for (var item in data) PublicConference(item[0], item[1])];
  }

  static Future<List<PublicConference>> get() {
    // todo: check cached data
    return fetch();
  }
}
