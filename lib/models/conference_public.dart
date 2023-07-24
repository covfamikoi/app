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
    return const [
      PublicConference(1, "RPIC 2024"),
      PublicConference(2, "Covfamikoi 2025"),
    ];
  }

  static Future<List<PublicConference>> get() {
    // todo: check cached data
    return fetch();
  }
}
