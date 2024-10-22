import 'package:cineflix/fonctionnalite/Cineflix/film/vues/film_card.dart';
import 'package:cineflix/fonctionnalite/Cineflix/film/vues/film_card_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/film_bloc.dart';
import '../film_services/film_reservation_service.dart';

class ReservedFilmsScreen extends StatefulWidget {
  @override
  _ReservedFilmsScreenState createState() => _ReservedFilmsScreenState();
}

class _ReservedFilmsScreenState extends State<ReservedFilmsScreen> {
  final ReservationService reservationService = ReservationService();
  late Future<List<int>> reservedFilmIds;

  @override
  void initState() {
    super.initState();
    reservedFilmIds = reservationService.getReservedFilms();
  }

  void _reloadReservations() {
    setState(() {
      reservedFilmIds = reservationService.getReservedFilms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Films Réservés'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reloadReservations,
          ),
        ],
      ),
      body: FutureBuilder<List<int>>(
        future: reservedFilmIds,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue.'));
          }
          final reservedFilmIds = snapshot.data ?? [];
          return BlocBuilder<FilmBloc, FilmState>(
            builder: (context, state) {
              if (state is FilmLoadSuccess) {
                final reservedFilms = state.films.where((film) => reservedFilmIds.contains(film.id)).toList();
                return ListView.builder(
                  itemCount: reservedFilms.length,
                  itemBuilder: (context, index) {
                    final film = reservedFilms[index];
                    return ListTile(
                      title: FilmCard2(film: film,),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () async {
                          await reservationService.cancelReservation(film.id!);
                          _reloadReservations(); // Recharger la liste
                        },
                      ),
                    );
                  },
                );
              }
              return Center(child: Text('Aucun film réservé.'));
            },
          );
        },
      ),
    );
  }
}
