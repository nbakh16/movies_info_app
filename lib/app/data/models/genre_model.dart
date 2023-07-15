import 'dart:convert';

Genre genreFromJson(String str) => Genre.fromJson(json.decode(str));

String genreToJson(Genre data) => json.encode(data.toJson());

class Genre {
  List<GenreElement> genres;

  Genre({
    required this.genres,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    genres: List<GenreElement>.from(json["genres"].map((x) => GenreElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class GenreElement {
  int id;
  String name;

  GenreElement({
    required this.id,
    required this.name,
  });

  factory GenreElement.fromJson(Map<String, dynamic> json) => GenreElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
