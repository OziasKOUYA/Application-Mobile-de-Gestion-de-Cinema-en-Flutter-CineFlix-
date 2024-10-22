import 'dart:convert';
import '../../../exceptions/exceptions.dart';
import '../../../utils/http/client_http.dart';
import 'models/salle.dart';

class SalleService {
  final String baseUrl = "salle";


  Future<List<Salle>> getSalles() async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "GET",

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Salle.fromJson(item)).toList();
      } else {
        throw  FuzExceptions("Echec du chargement des salles");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addSalle(Salle salle) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "POST",
        body: jsonEncode(salle.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      } else {
        throw FuzExceptions('Echec lors de l\'ajout de la salle');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSalle(Salle salle) async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "PUT",
        body: jsonEncode(salle.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors dae la modification d\'une salle');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSalle(Salle salle) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "DELETE",
        body: jsonEncode(salle),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors de la suppresion d\'une salle');
      }
    } catch (e) {
      rethrow;
    }
  }
}