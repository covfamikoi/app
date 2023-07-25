import 'dart:convert';

import 'package:app/constants.dart';
import 'package:http/http.dart' as http;

class Conference {
  final int id;

  final String title;
  final String password;

  final String startTs;
  final String endTs;

  final double topLeftLat;
  final double topLeftLon;
  final int widthInTiles;
  final int heightInTiles;

  final List<int> admins;

  const Conference(
      this.id,
      this.title,
      this.password,
      this.startTs,
      this.endTs,
      this.topLeftLat,
      this.topLeftLon,
      this.widthInTiles,
      this.heightInTiles,
      this.admins);

  Conference.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        password = json["password"],
        startTs = json["start_ts"],
        endTs = json["end_ts"],
        topLeftLat = json["top_left_lat"],
        topLeftLon = json["top_left_lon"],
        widthInTiles = json["width_in_tiles"],
        heightInTiles = json["height_in_tiles"],
        admins = json["admins"].cast<int>();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'password': password,
        'start_ts': startTs,
        'end_ts': endTs,
        'top_left_lat': topLeftLat,
        'top_left_lon': topLeftLon,
        'width_in_tiles': widthInTiles,
        'height_in_tiles': heightInTiles,
        'admins': admins,
      };

  static Future<Conference> fetch(int id, String password) async {
    var ret = await http.get(buildUrl("api/conferences"), headers: {
      "conference-id": id.toString(),
      "conference-password": password
    });

    if (ret.statusCode != 200) {
      throw ret.statusCode;
    }

    var data = jsonDecode(ret.body);
    return Conference.fromJson(data);
  }

  static Conference? cached(int id) {
    return null;
  }
}
