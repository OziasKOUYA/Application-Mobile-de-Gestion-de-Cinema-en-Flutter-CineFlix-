
import 'package:cineflix/fonctionnalite/Cineflix/salle/models/salle.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/bloc/salle_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/vues/salle_details_sheet.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/vues/salle_update_dialog.dart';
import 'package:cineflix/utils/helper/fonctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import 'salle_add_dialog.dart';

class SalleScreen extends StatefulWidget {

  const SalleScreen(
      {super.key,
      });

  @override
  SalleScreenState createState() => SalleScreenState();
}

class SalleScreenState extends State<SalleScreen> {




  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SalleBloc, SalleState>(
                builder: (context, state) {
                  if (state is SalleOperationFailure) {
                    FuzHelperFunctions.showToastNoContext(state.error);
                    return  Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<SalleBloc>().add(
                                      LoadSalles());
                                },
                                child: const Icon(Icons.refresh),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  AddSalleDialog.show(
                                    context,

                                        (Salle salle) {
                                      context.read<SalleBloc>().add(AddSalle( salle));
                                    },
                                  );
                                },
                                child:const Icon(Icons.add,),
                              ),
                            ],
                          ),
                          const Center(
                            child: Text(
                              'Une erreur s\'est produite,contactez l\'assistance si le raffraichissement n\'aboutit pas ou si l\'insertion de nouvelles données ne passe pas',
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                    );
                  }
                  if (state is SalleLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SalleLoadSuccess) {
                    final salles = state.salles;



                    if (salles.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                      context.read<SalleBloc>().add(LoadSalles(
                                          ));
                                  },
                                  child: const Icon(Icons.refresh_outlined),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    AddSalleDialog.show(
                                      context,

                                          (Salle salle) {
                                        context.read<SalleBloc>().add(AddSalle( salle));
                                      },
                                    );
                                  },
                                  child: const Icon(
                                        Icons.add,
                                      ),


                                ),
                              ],
                            ),
                            const Text('Rien à afficher')
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<SalleBloc>().add(LoadSalles(
                                        ));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.refresh),
                                      const SizedBox(
                                        width: 5,
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  onPressed: () {
                                    AddSalleDialog.show(
                                      context,

                                          (Salle salle) {
                                        context.read<SalleBloc>().add(AddSalle( salle));
                                      },
                                    );
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Ajouter'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),

                              ]),
                        ),
                        SizedBox(
                          height: FuzHelperFunctions.screenHeight(context)/2,
                          child: Scrollbar(
                              thumbVisibility: false,
                              child: RefreshIndicator(
                                  onRefresh: () async {
                                      context.read<SalleBloc>().add(LoadSalles(
                                          ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ListView.builder(

                                          itemCount: salles.length,
                                          itemBuilder: (context, index) {
                                            final salle= salles[index];
                                              return Dismissible(
                                                key: Key(
                                                    salle.nombre_de_place.toString()),
                                                direction:
                                                    DismissDirection.endToStart,
                                                background: Container(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(16),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(LineIcons.trash,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onError),
                                                            Text('Supprimer',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .onError)),
                                                          ],
                                                        ),
                                                      ),
                                                  ),
                                                ),
                                                confirmDismiss:
                                                    (direction) async {
                                                  if (direction ==
                                                      DismissDirection
                                                          .endToStart) {
                                                    return await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          icon: const Icon(
                                                              LineIcons.trash),
                                                          iconColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .error,
                                                          title: Text(
                                                              'Confirmation',
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary)),
                                                          content: const Text(
                                                            textAlign: TextAlign.center,
                                                              'Êtes-vous sûr de vouloir supprimer cet élément ?'),
                                                          actions: [
                                                            OutlinedButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false),
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                side: BorderSide(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                              child: const Text(
                                                                  'Annuler'),
                                                            ),
                                                            FilledButton(
                                                              style: FilledButton.styleFrom(
                                                                  backgroundColor: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .error),
                                                              onPressed:
                                                                  ()  {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);
                                                              },
                                                              child: Text(
                                                                'Supprimer',
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .onError),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                  return false;
                                                },
                                                onDismissed: (direction) {
                                                  if (direction ==
                                                      DismissDirection
                                                          .endToStart) {
                                                    context.read<SalleBloc>().add(DeleteSalle(salle));
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                          child: Text(
                                                              '${index + 1}')),
                                                      title: Text(
                                                        '${salle.nombre_de_place}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),

                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            '${salle.libelle}',
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        DetailsSalleBottomSheet.show(context, salle);
                                                      },
                                                      onLongPress: () {
                                                        UpdateSalleDialog.show(
                                                          context,

                                                          salle,
                                                              (Salle updatedSalle) {
                                                            context.read<SalleBloc>().add(UpdateSalle(updatedSalle));
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          ),
                                    ),
                                  ))),
                        ),
                      ],
                    );
                  }

                  return Center(
                      child: Column(
                    children: [

                      const Text("Il n'y a pas de données."),
                    ],
                  ));
                },

        );
  }
}
