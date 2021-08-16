import 'package:boardmate/model/match.dart';
import 'package:boardmate/provider/match_card.dart';
import 'package:boardmate/service/match.dart';
import 'package:boardmate/widget/match_card.dart';
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
            onTap: () => print('object'), // TODO: implement a menu button
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
                            List<Match> matches = context.watch<List<Match>>();
                            if (matches.length > 0)
                              return ListView.builder(
                                itemCount: matches.length,
                                itemBuilder: (context, index) =>
                                    ChangeNotifierProvider(
                                  create: (context) =>
                                      MatchCardProvider(matches[index]),
                                  builder: (context, _) => MatchCard(
                                    match: matches[index],
                                  ),
                                ),
                              );
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                'There is no matches...\nPlease add a match by clicking the + buttom above!',
                                textAlign: TextAlign.center,
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
