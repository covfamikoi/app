class Conference {
  final int id;

  final String title;
  final String info;
  final String password;

  final int startTs;
  final int endTs;

  final double topLeftLat;
  final double topLeftLon;
  final int widthInTiles;
  final int heightInTiles;

  final List<int> admins;

  const Conference(
      this.id,
      this.title,
      this.info,
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
        info = json["info"],
        password = json["password"],
        startTs = json["start_ts"],
        endTs = json["endTs"],
        topLeftLat = json["top_left_lat"],
        topLeftLon = json["top_left_lon"],
        widthInTiles = json["width_in_tiles"],
        heightInTiles = json["height_in_tiles"],
        admins = json["admins"];

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'info': info,
    'password': password,
    'start_ts': startTs,
    'end_ts': endTs,
    'top_left_lat': topLeftLat,
    'top_left_lon': topLeftLon,
    'width_in_tiles': widthInTiles,
    'height_in_tiles': heightInTiles,
    'admins': admins,
  };

  static Future<Conference?> fetch(int id, String password) async {
    var conf = switch (id) {
      1 => const Conference(1, "RPIC 2024", "RPIC in 2024", "youalreadyknowthistho", 0, 50000, 80, 80, 10, 10, [1]),
      2 => const Conference(2, "Covfamikoi 2025", "Covfamikoi in 2025", "supersecretpassword", 0, 50000, 80, 80, 10, 10, [1]),
      _ => null,
    };
    if (conf == null) {
      return null;
    }
    if (password != conf.password) {
      throw 401;
    }
    return conf;
  }

  static Conference? cached(int id) {
    // todo: cache
    return switch (id) {
      1 => const Conference(2, "RPIC 2024", "RPIC in 2024", "youalreadyknowthistho", 0, 50000, 80, 80, 10, 10, [1]),
      _ => null,
    };
  }
}
