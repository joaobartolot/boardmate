import 'package:boardmate/model/game.dart';
import 'package:boardmate/model/match.dart';
import 'package:boardmate/provider/match_card.dart';
import 'package:boardmate/service/game.dart';
import 'package:boardmate/service/match.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({
    Key? key,
    required this.match,
  }) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    return match.gameId.isNotEmpty
        ? StreamProvider.value(
            value: GameService.getGame(match.gameId),
            initialData: Game(
              id: '',
              name: '',
              timesPlayed: 0,
            ),
            builder: (context, _) => GestureDetector(
              onTap: () => context.read<MatchCardProvider>().isExpanded =
                  !context.read<MatchCardProvider>().isExpanded,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                context.watch<Game>().name,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Visibility(
                              visible:
                                  context.watch<MatchCardProvider>().isExpanded,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(99.0),
                                    onTap: () => Navigator.of(context)
                                        .pushNamed('/create_match',
                                            arguments: match),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(99.0),
                                    onTap: () => MatchService.deleteMatch(
                                      match.id,
                                    ).then((value) => context
                                            .read<MatchCardProvider>()
                                            .isExpanded =
                                        !context
                                            .read<MatchCardProvider>()
                                            .isExpanded),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: context.watch<MatchCardProvider>().isExpanded,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Players: ${match.playersToString()}'),
                              SizedBox(height: 5.0),
                              Text('Winner: ${match.winner}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
