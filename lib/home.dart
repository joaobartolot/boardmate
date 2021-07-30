import 'package:boardmate/model/game.dart';
import 'package:boardmate/model/match.dart';
import 'package:boardmate/service/game.dart';
import 'package:boardmate/service/match.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Matches'),
                    IconButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/create_match'),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                  child: Container(
                    color: Colors.black38,
                  ),
                ),
                Flexible(
                  child: StreamProvider<List<Match>>.value(
                    value: MatchService.getAllMatches(),
                    initialData: [],
                    builder: (context, _) {
                      List<Match> matchList = Provider.of<List<Match>>(context);
                      return ListView.builder(
                        itemCount: matchList.length,
                        itemBuilder: (context, index) => StreamProvider.value(
                          value: GameService.getGame(matchList[index].gameId),
                          initialData: Game(id: '', name: '', timesPlayed: 0),
                          builder: (context, child) {
                            Game game = Provider.of<Game>(context);
                            return Text(game.name);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
