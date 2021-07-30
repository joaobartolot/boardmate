import 'dart:ffi';

import 'package:boardmate/model/game.dart';
import 'package:boardmate/provider/create_match.dart';
import 'package:boardmate/service/game.dart';
import 'package:boardmate/service/match.dart';
import 'package:boardmate/widget/input_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMatchPage extends StatelessWidget {
  const CreateMatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateMatchProvider>(
      create: (context) => CreateMatchProvider(),
      builder: (context, _) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputContainer(
                      header: Text(
                        'Game:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Consumer<CreateMatchProvider>(
                        builder: (context, provider, _) =>
                            StreamProvider<List<Game>>.value(
                          value: GameService.getAllGames(),
                          initialData: [],
                          builder: (context, _) {
                            List<Game> games = Provider.of<List<Game>>(context);
                            if (games.isNotEmpty &&
                                provider.dropdownValueGame.isEmpty)
                              provider.setDefaultDropdownValue(games.first.id);
                            return DropdownButton(
                              value: provider.dropdownValueGame,
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (String? value) =>
                                  provider.dropdownValueGame = value ?? "",
                              hint: Text('Select a game...'),
                              items: games.length > 0
                                  ? games
                                      .map(
                                        (e) => DropdownMenuItem<String>(
                                          child: Text(e.name),
                                          value: e.id,
                                        ),
                                      )
                                      .toList()
                                  : null,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    InputContainer(
                      header: Text(
                        'Players:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: "Add a player",
                              ),
                              controller: Provider.of<CreateMatchProvider>(
                                context,
                                listen: false,
                              ).nameController,
                            ),
                          ),
                          SizedBox(
                            width: 1.0,
                            height: 30.0,
                            child: Container(
                              color: Colors.black38,
                            ),
                          ),
                          IconButton(
                            onPressed: Provider.of<CreateMatchProvider>(
                              context,
                              listen: false,
                            ).addPlayerToList,
                            icon: Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Consumer<CreateMatchProvider>(
                        builder: (context, provider, _) => provider
                                    .players.length >
                                0
                            ? ListView.builder(
                                itemCount: provider.players.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () => provider.winnerIndex = index,
                                  child: Container(
                                    color: provider.winnerIndex == index
                                        ? Colors.blue
                                        : null,
                                    child: Dismissible(
                                      key: Key(provider.players[index]),
                                      onDismissed: (direction) =>
                                          provider.removePlayer(index),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Text(
                                                  provider.players[index],
                                                  style: provider.winnerIndex ==
                                                          index
                                                      ? TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        )
                                                      : TextStyle(),
                                                ),
                                              ),
                                            ),
                                            if (provider.winnerIndex == index)
                                              Icon(
                                                Icons.emoji_events_rounded,
                                                color: Colors.white,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'There is no player yet 😕...\nPlease add a player using the input and buttom above!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => MatchService.addMatch(
                              Provider.of<CreateMatchProvider>(
                                context,
                                listen: false,
                              ).getModel(),
                            ).listen(
                              (data) => Navigator.of(context).pop(),
                            ),
                            child: Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
