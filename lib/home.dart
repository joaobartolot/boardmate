import 'package:boardmate/model/game.dart';
import 'package:boardmate/model/match.dart';
import 'package:boardmate/service/game.dart';
import 'package:boardmate/service/match.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(99.0),
            onTap: () => print('object'),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(99.0),
                child:
                    Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 20.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Matches',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed('/create_match'),
                            borderRadius: BorderRadius.circular(99),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1,
                        child: Container(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Flexible(
                        child: StreamProvider<List<Match>>.value(
                          value: MatchService.getAllMatches(),
                          initialData: [],
                          builder: (context, _) {
                            List<Match> matchList =
                                Provider.of<List<Match>>(context);
                            return ListView.builder(
                              itemCount: matchList.length,
                              itemBuilder: (context, index) =>
                                  StreamProvider.value(
                                value: GameService.getGame(
                                    matchList[index].gameId),
                                initialData:
                                    Game(id: '', name: '', timesPlayed: 0),
                                builder: (context, child) {
                                  Game game = Provider.of<Game>(context);
                                  return Card(
                                      elevation: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(game.name),
                                          ],
                                        ),
                                      ));
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
          ],
        ),
      ),
    );
  }
}
