import 'dart:async';
import 'dart:convert';

import '../../../utils/helper/secureStorage.dart';
import '../../../utils/http/client_http.dart';
import 'models/user_add.dart';


enum AuthentificationStatus { unknown,autoLoginAttempt, authenticated, unauthenticated }

class AuthentificationService{
  final _controller = StreamController<AuthentificationStatus>();
  final String  baseUrl ='dj-rest-auth/';
/*

  Stream<AuthentificationStatus> get status async* {
    final storedStatus = await FuzSecureStorageManager.read('stored_status');
    if ( storedStatus == '0') {
      yield AuthentificationStatus.unauthenticated;
    } else if(storedStatus =='1'){
      yield AuthentificationStatus.authenticated;
    }else{
      yield AuthentificationStatus.unknown;
    }
    yield* _controller.stream;
  }*/
  Stream<AuthentificationStatus> get status async* {
    yield AuthentificationStatus.autoLoginAttempt;
    yield* _controller.stream;
  }

  Future<void> register(User_add user ) async {
    final Map<String, dynamic> requestBody = {
      'username': user.username,
      'email': user.email,
      'password1': user.password1,
      'password2': user.password2,


    };

    try {
      final response = await FuzHttpHelper.makeRequest(
          "${baseUrl}registration/",
          method: "POST",
          body:jsonEncode(requestBody)
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
       print("inscription réussi");

      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final jsonResponse = json.decode(response.body);
        throw Exception(jsonResponse);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw Exception('Erreur serveur');
      } else {
        throw Exception('Echec de la connexion_internet');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User_add?> login(User_add user) async {
    final Map<String, dynamic> requestBody = {
      'username':user.username,
      'email': user.email,
      'password': user.password1,
    };
    try {
      final response = await FuzHttpHelper.makeRequest(
        "${baseUrl}login/",
        method: "POST",
        body: jsonEncode(requestBody),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = json.decode(response.body);
        final key = jsonResponse['key'] ;
        await FuzSecureStorageManager.write('access_token', key ?? '');
        await FuzSecureStorageManager.write('username', user.username ?? '');
        await FuzSecureStorageManager.write('password', user.password1 ?? '');
        await FuzSecureStorageManager.write('email', user.email ?? '');
        _controller.add(AuthentificationStatus.authenticated);
        return user;
        // Enregistrer les tokens et le statut dans le stockage sécurisé


      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final jsonResponse = json.decode(response.body.trim());
        final errorMessage = jsonResponse['detail'] ;
        throw Exception(errorMessage);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        throw Exception('Erreur serveur');
      } else {
        throw Exception('Echec de la connexion_internet');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User_add> getUser(String? key) async {
    if (key == null) {
      throw Exception('key is null');
    }
    final Map<String, dynamic> requestBody = {
      'key':key,
    };
    Map<String, String> additionalParams = {};
    additionalParams['key'] = key;
    final response = await FuzHttpHelper.makeRequest(
      "${baseUrl}user/",
      method: "GET",
      body:jsonEncode(requestBody),
      useToken: true,
     additionalParams: additionalParams
    );


    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User_add.fromJson(responseBody);
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized: check your JWT');
    } else if (response.statusCode == 404) {
      throw Exception('API endpoint not found');
    } else {
      throw Exception(
          'Failed to fetch user details: ${response.statusCode}, ${response
              .body}');
    }
  }


}
