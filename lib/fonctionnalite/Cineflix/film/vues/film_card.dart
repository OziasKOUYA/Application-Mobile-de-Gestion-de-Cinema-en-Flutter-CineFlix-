import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../film_services/film_reservation_service.dart';
import '../models/film.dart';
import 'film_detail.dart';
 // Importez la page de détail

class FilmCard extends StatelessWidget {
  final Film film;
  final ReservationService reservationService = ReservationService();
  final VoidCallback onReserve;

  FilmCard({
    required this.film,
    required this.onReserve,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'filmImage_${film.titre}',
                child: CachedNetworkImage(
                  imageUrl: film.affiche!,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: FutureBuilder<List<int>>(
                  future: reservationService.getReservedFilms(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final isReserved = snapshot.data!.contains(film.id);
                      return ElevatedButton(
                        onPressed: isReserved
                            ? null
                            : () async {
                          await reservationService.reserveFilm(film.id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${film.titre} réservé avec succès !')),
                          );
                          onReserve();
                        },
                        child: Text(isReserved ? 'Réservé' : 'Réserver'),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film.titre!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Acteur principal : ${film.acteur_principal}"),
                Text("Durée : ${film.duree}"),
                Text("Description : ${film.description}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
