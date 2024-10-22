import 'dart:convert';
import 'package:cineflix/fonctionnalite/Cineflix/projection/models/projection.dart';

import '../../../exceptions/exceptions.dart';
import '../../../utils/http/client_http.dart';



class ProjectionService {
  final String baseUrl = "projection";

  get projection => null;
  Future<List<Projection>> getProjection() async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "GET",

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Projection.fromJson(item)).toList();
      } else {
        throw  FuzExceptions("Echec du chargement des projections");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProjection(Projection projection) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "POST",
        body: jsonEncode(projection.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      } else {
        throw FuzExceptions('Echec lors de l\'ajout de la projection');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProjection(Projection projection) async {
    try {

      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "PUT",
        body: jsonEncode(projection.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors dae la modification d\'une projection');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProjection(Projection projection) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
        baseUrl,
        method: "DELETE",
        body: jsonEncode(projection),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors de la suppresion d\'une projection');
      }
    } catch (e) {
      rethrow;
    }
  }
}