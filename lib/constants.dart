const String apiBase = "localhost";

Uri buildUrl(String path) {
  return Uri(scheme: "http", host: apiBase, port:8000, path: path);
}
