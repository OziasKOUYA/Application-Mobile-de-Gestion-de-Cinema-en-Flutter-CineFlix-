import 'dart:convert';
import '../../../../exceptions/exceptions.dart';
import '../../../../utils/http/client_http.dart';
import '../models/film.dart';


class FilmService {
  final String baseUrl = "film";

  get film=> null;
  Future<List<Film>> getFilm() async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "GET",

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Film.fromJson(item)).toList();
      } else {
        throw  FuzExceptions("Echec du chargement des films");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFilm(Film film) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "POST",
        body: jsonEncode(film.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      } else {
        throw FuzExceptions('Echec lors de l\'ajout du film');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFilm(Film film) async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "PUT",
        body: jsonEncode(film.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors dae la modification d\'un film');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFilm(Film film) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "DELETE",
        body: jsonEncode(film),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors de la suppresion d\'un film');
      }
    } catch (e) {
      rethrow;
    }
  }
}