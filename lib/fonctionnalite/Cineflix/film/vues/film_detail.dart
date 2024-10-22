import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/film.dart';

class FilmDetailPage extends StatelessWidget {
  final Film film;

  FilmDetailPage({
    required this.film,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film.titre!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'filmImage_${film.titre}', // Utilisez la même clé Hero que dans FilmCard
              child: CachedNetworkImage(
                imageUrl: film.affiche!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film.titre!,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Acteur principal: ${film.acteur_principal}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    film.description!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Durée: ${film.duree}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
