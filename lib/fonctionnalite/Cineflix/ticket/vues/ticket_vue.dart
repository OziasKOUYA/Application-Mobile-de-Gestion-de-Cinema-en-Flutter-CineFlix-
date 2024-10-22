
import 'package:cineflix/fonctionnalite/Cineflix/ticket/bloc/ticket_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/models/ticket.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/vues/ticket_details_sheet.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/vues/ticket_update_dialog.dart';
import 'package:cineflix/utils/helper/fonctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import 'ticket_add_dialog.dart';

class TicketScreen extends StatefulWidget {

  const TicketScreen(
      {super.key,
      });

  @override
  TicketScreenState createState() => TicketScreenState();
}

class TicketScreenState extends State<TicketScreen> {




  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  if (state is TicketOperationFailure) {
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
                                  context.read<TicketBloc>().add(
                                      LoadTickets());
                                },
                                child: const Icon(Icons.refresh),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  AddTicketDialog.show(
                                    context,

                                        (Ticket ticket) {
                                      context.read<TicketBloc>().add(AddTicket( ticket));
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
                  if (state is TicketLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TicketLoadSuccess) {
                    final tickets = state.tickets;



                    if (tickets.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                      context.read<TicketBloc>().add(LoadTickets(
                                          ));
                                  },
                                  child: const Icon(Icons.refresh_outlined),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    AddTicketDialog.show(
                                      context,

                                          (Ticket ticket) {
                                        context.read<TicketBloc>().add(AddTicket( ticket));
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
                                    context.read<TicketBloc>().add(LoadTickets(
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
                                    AddTicketDialog.show(
                                      context,

                                          (Ticket ticket) {
                                        context.read<TicketBloc>().add(AddTicket( ticket));
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
                                      context.read<TicketBloc>().add(LoadTickets(
                                          ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ListView.builder(

                                          itemCount: tickets.length,
                                          itemBuilder: (context, index) {
                                            final ticket= tickets[index];
                                              return Dismissible(
                                                key: Key(
                                                    ticket.numero.toString()),
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
                                                    context.read<TicketBloc>().add(DeleteTicket(ticket));
                                                  }
                                                },
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      leading: CircleAvatar(
                                                          child: Text(
                                                              '${index + 1}')),
                                                      title: Text(
                                                        '${ticket.numero}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),

                                                      trailing: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            '${ticket.prix}',
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
                                                        DetailsTicketBottomSheet.show(context, ticket);
                                                      },
                                                      onLongPress: () {
                                                        UpdateTicketDialog.show(
                                                          context,

                                                          ticket,
                                                              (Ticket updatedTicket) {
                                                            context.read<TicketBloc>().add(UpdateTicket(updatedTicket));
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
