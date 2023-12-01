import 'dart:convert';
import 'package:movies_app/models/movie.dart';

class Person {
  int id;
  String name;
  String profilePath;
  String placeOfBirth;
  String birthday;
  String biography;
  double popularity;
  List<Movie> credits = [];

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.placeOfBirth,
    required this.birthday,
    required this.biography,
    required this.popularity,
    required this.credits,
  });

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      birthday: map['birthday'] ?? '',
      biography: map['biography'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      credits: [],
    );
  }

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
