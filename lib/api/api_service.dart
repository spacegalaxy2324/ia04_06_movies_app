import 'dart:convert';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/person.dart';
import 'package:movies_app/models/review.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Person>?> getPeople(bool popular) async {
    List<Person> people = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      if (popular) {
        res['results'].take(6).forEach(
              (m) => people.add(
                Person.fromMap(m),
              ),
            );
      } else {
        res['results'].skip(6).take(14).forEach(
              (m) => people.add(
                Person.fromMap(m),
              ),
            );
      }

      return people;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
              Movie.fromMap(m),
            ),
          );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=YourApiKey&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<Person?> getPersonDetails(Person parameterPerson) async {
    try {
      Person detailedPerson = parameterPerson;
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/person/${parameterPerson.id}?api_key=${Api.apiKey}&language=en-US'));
      var res = jsonDecode(response.body);
      detailedPerson.biography = res['biography'];
      detailedPerson.birthday = res['birthday'];
      detailedPerson.placeOfBirth = res['place_of_birth'];

      // GET MOVIES
      response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/person/${parameterPerson.id}/combined_credits?api_key=${Api.apiKey}&language=en-US'));
      res = jsonDecode(response.body);
      List<Movie> movies = [];
      res['cast'].forEach(
        (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      detailedPerson.credits = movies;
      return detailedPerson;
    } catch (e) {
      return null;
    }
  }
}
