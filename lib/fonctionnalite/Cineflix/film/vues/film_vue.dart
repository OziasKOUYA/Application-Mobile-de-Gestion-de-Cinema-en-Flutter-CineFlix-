
import 'package:cineflix/fonctionnalite/Cineflix/film/vues/film_card.dart';
import 'package:cineflix/ressources_communes/widget/slides_widegt.dart';
import 'package:cineflix/utils/helper/fonctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../bloc/film_bloc.dart';
import '../models/film.dart';
import 'film_add_dialog.dart';
import 'film_details_sheet.dart';
import 'film_update_dialog.dart';



class FilmScreen extends StatefulWidget {

  const FilmScreen(
      {super.key,
      });

  @override
  FilmScreenState createState() => FilmScreenState();
}

class FilmScreenState extends State<FilmScreen> {

  @override
  void initState() {
    super.initState();
    context.read<FilmBloc>().add(const LoadFilms());
  }

  void _reloadFilms() {
    setState(() {
      context.read<FilmBloc>().add(const LoadFilms());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmBloc, FilmState>(
      builder: (context, state) {
        if (state is FilmOperationFailure) {
          FuzHelperFunctions.showToastNoContext(state.error);
          return _buildErrorUI();
        }
        if (state is FilmLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FilmLoadSuccess) {
          final films = state.films;

          if (films.isEmpty) {
            return _buildEmptyUI();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideCarousel(),
              SizedBox(
                height: FuzHelperFunctions.screenHeight(context) / 2,
                child: Scrollbar(
                  thumbVisibility: false,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _reloadFilms();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: films.length,
                          itemBuilder: (context, index) {
                            final film = films[index];
                            return FilmCard(
                              film: film,
                              onReserve: _reloadFilms,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return _buildEmptyUI();
      },
    );
  }

  Widget _buildErrorUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<FilmBloc>().add(LoadFilms());
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
        const Center(
          child: Text(
            'Une erreur s\'est produite, contactez l\'assistance si le rafraîchissement n\'aboutit pas',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _buildEmptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<FilmBloc>().add(LoadFilms());
                },
                child: const Icon(Icons.refresh_outlined),
              ),
            ],
          ),
          const Text('Rien à afficher'),
        ],
      ),
    );
  }
}
