import 'dart:convert';

import 'package:cineflix/fonctionnalite/Cineflix/ticket/models/ticket.dart';

import '../../../exceptions/exceptions.dart';
import '../../../utils/http/client_http.dart';

class TicketService {
  final String baseUrl = "ticket";
  Future<List<Ticket>> getTickets() async {
    try {

      final response = await FuzHttpHelper.makeRequest(
          baseUrl,
          method: "GET",

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Ticket.fromJson(item)).toList();
      } else {
        throw  FuzExceptions("Echec du chargement des tickets");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTicket(Ticket ticket) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
          baseUrl,
          method: "POST",
          body: jsonEncode(ticket.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      } else {
        throw FuzExceptions('Echec lors de l\'ajout de la recette');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTicket(Ticket ticket) async {
    try {

      final response = await FuzHttpHelper.makeRequest(
          baseUrl,
          method: "PUT",
          body: jsonEncode(ticket.toJson()),

      );
      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors dae la modification d\'un ticket');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTicket(Ticket ticket) async {
    try {
      final response = await FuzHttpHelper.makeRequest(
          baseUrl,
          method: "DELETE",
          body: jsonEncode(ticket),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {

      }else{
        throw FuzExceptions('Echec lors de la suppresion d\'un ticket');
      }
    } catch (e) {
      rethrow;
    }
  }
}