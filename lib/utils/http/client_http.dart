import 'dart:async';
import 'dart:io';


import 'package:http/http.dart' as http;

import '../../exceptions/exceptions.dart';
import '../../exceptions/internet_exception.dart';
import '../constantes/api_constants.dart';
import '../helper/secureStorage.dart';



class FuzHttpHelper {
  static Future<http.Response> makeRequest(String endpoint, {
    String? body,
    required String method,
    bool useToken = false,
    Map<String, String>? additionalParams,
    Duration timeoutDuration = const Duration(seconds: 30),
  }) async {

    var fullUrl = "${ApiConstants.baseUrl}$endpoint";


    String? firstParamKey; // Déclaration de firstParamKey en dehors de la condition

    // Ajout du premier paramètre s'il existe dans additionalParams
    if (additionalParams != null && additionalParams.isNotEmpty) {
      // Ajoutez ici la clé et la valeur du premier paramètre
      firstParamKey = additionalParams.keys.first;
      final firstParamValue = additionalParams[firstParamKey];
      fullUrl += "?$firstParamKey=$firstParamValue";
    }

    // Ajout des paramètres supplémentaires à l'URL
    if (additionalParams != null) {
      additionalParams.forEach((key, value) {
        // On ignore le premier paramètre car il a déjà été ajouté
        if (key != firstParamKey) {
          fullUrl += "&$key=$value";
        }
      });
    }
    final token = await getTokenFromSomewhere();
    if (useToken && token == null) {
      throw Exception("Token requis mais non trouvé");
    }

    final headers = <String, String>{
      if (useToken) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };

  print(fullUrl);
    http.Response response;
    try {
      switch (method.toUpperCase()) {
        case "POST":
          response = await http.post(Uri.parse(fullUrl), headers: headers, body: body).timeout(timeoutDuration);
          break;
        case "GET":
          response = await http.get(Uri.parse(fullUrl), headers: headers).timeout(timeoutDuration);
          break;
        case "PUT":
          response = await http.put(Uri.parse(fullUrl), headers: headers, body: body).timeout(timeoutDuration);
          break;
        case "PATCH":
          response = await http.patch(Uri.parse(fullUrl), headers: headers, body: body).timeout(timeoutDuration);
          break;
        case "DELETE":
          response = await http.delete(Uri.parse(fullUrl), headers: headers).timeout(timeoutDuration);
          break;
        default:
          throw Exception("Méthode HTTP non prise en charge : $method");
      }
    } on SocketException catch (e) {
      print(e.toString());

      throw FuzExceptions('Impossible de contacter le serveur distant');
    } on HttpException catch (_) {
      throw InternetException('No internet connection');
    }on TimeoutException catch (_) {
      throw FuzExceptions('Impossible de contacter le serveur distant,verifiez votre internet');
    } catch (e) {
     rethrow;
    }

    return response;
  }

  static Future<void> uploadFileIfNotNull(File file, String fieldName, http.MultipartRequest request) async {
    final fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
    final fileLength = await file.length();

    // Créer un champ de fichier multipart
    final multipartFile = http.MultipartFile(
      fieldName,
      fileStream,
      fileLength,
      filename: file.path,
    );

    // Ajouter le fichier à la demande multipart
    request.files.add(multipartFile);
    }
  static Future<http.Response> uploadFiles(String endpoint,
      {required List<File> files,
        String method = "POST",
        bool useToken = false,
        required Map<String, dynamic> jsonData
      }) async {

    var fullUrl = "${ApiConstants.baseUrl}$endpoint";
    final token = await getTokenFromSomewhere();
    if (useToken && token == null) {
      throw Exception("Token requis mais non trouvé");
    }
    final headers = <String, String>{
      if (useToken) 'Authorization': 'Bearer $token',

    };

    var request = http.MultipartRequest(method.toUpperCase(), Uri.parse(fullUrl));

    request.headers.addAll(headers);



    jsonData.forEach((key, value) {
      request.fields[key] =value.toString();
    });


    List<String> imageNames = [];

    // Add image files to the multipart request
    for (var file in files) {
      // Get the filename and add it to the list
      String filename = file.path.split('/').last;
      imageNames.add(filename);

      request.files.add(await http.MultipartFile.fromPath(
        'images',
        file.path,
        filename: file.path.split('/').last, // Nom du fichier
      ));
    }

    // Add the list of image filenames as a single field
    request.fields['images'] =imageNames.toString();

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    return http.Response(responseData, response.statusCode);

  }

  static Future<String?> getTokenFromSomewhere() async{
    return await FuzSecureStorageManager.read('access_token');
  }

}