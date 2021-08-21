import 'package:boardmate/model/game.dart';
import 'package:boardmate/model/match.dart';
import 'package:boardmate/provider/create_match.dart';
import 'package:boardmate/service/game.dart';
import 'package:boardmate/service/match.dart';
import 'package:boardmate/widget/back_appbar_button.dart';
import 'package:boardmate/widget/input_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class CreateMatchPage extends StatelessWidget {
  const CreateMatchPage({
    Key? key,
  }) : super(key: key);

  // TODO: Change all the hard coded colors
  @override
  Widget build(BuildContext context) {
    Match? match = ModalRoute.of(context)!.settings.arguments as Match?;
    return ChangeNotifierProvider<CreateMatchProvider>(
      create: (context) => match != null
          ? CreateMatchProvider.fromMatch(
              match: match,
            )
          : CreateMatchProvider(players: []),
      builder: (context, _) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackAppBarButton(),
            title: Text('Create match'),
            centerTitle: true,
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(99.0),
                onTap: () => print('object'),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99.0),
                    child: Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
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
                            errorText: 'Please select the game',
                            validationError: context
                                .read<CreateMatchProvider>()
                                .showDropdownError,
                            child: Consumer<CreateMatchProvider>(
                              builder: (context, provider, _) =>
                                  StreamProvider<List<Game>>.value(
                                value: GameService.getAllGames(),
                                initialData: [],
                                builder: (context, _) {
                                  List<Game> games =
                                      context.watch<List<Game>>();
                                  if (games.isNotEmpty &&
                                      provider.dropdownValueGame
                                          .isEmpty) if (match == null)
                                    provider.setDefaultDropdownValue(
                                        games.first.id);
                                  else
                                    provider
                                        .setDefaultDropdownValue(match.gameId);
                                  return DropdownButton(
                                    value: provider.dropdownValueGame,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    onChanged: (String? value) => provider
                                        .dropdownValueGame = value ?? "",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputContainer(
                                header: Text(
                                  'Match date:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                errorText: '',
                                validationError: false,
                                child: TextButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: context
                                          .read<CreateMatchProvider>()
                                          .gameTime,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    ).then(
                                      (value) => context
                                          .read<CreateMatchProvider>()
                                          .setDate(value),
                                    );
                                  },
                                  child: Text(
                                    Jiffy(context
                                            .watch<CreateMatchProvider>()
                                            .gameTime)
                                        .yMMMMEEEEd,
                                  ),
                                ),
                              ),
                              InputContainer(
                                header: Text(
                                  'Match time:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                errorText: '',
                                validationError: false,
                                child: TextButton(
                                  onPressed: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                        hour: context
                                            .read<CreateMatchProvider>()
                                            .gameTime
                                            .hour,
                                        minute: context
                                            .read<CreateMatchProvider>()
                                            .gameTime
                                            .minute,
                                      ),
                                    ).then(
                                      (value) => context
                                          .read<CreateMatchProvider>()
                                          .setTime(value),
                                    );
                                  },
                                  child: Text(
                                    // TODO: Change the Color of the text
                                    Jiffy(
                                      context
                                          .watch<CreateMatchProvider>()
                                          .gameTime,
                                    ).jm,
                                  ),
                                ),
                              ),
                            ],
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
                            errorText: 'Please add a player',
                            validationError: context
                                .read<CreateMatchProvider>()
                                .showPlayersError,
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
                                      controller: context
                                          .read<CreateMatchProvider>()
                                          .nameController),
                                ),
                                SizedBox(
                                  width: 1.0,
                                  height: 30.0,
                                  child: Container(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: context
                                      .read<CreateMatchProvider>()
                                      .addPlayerToList,
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
                                        onTap: () =>
                                            provider.winnerIndex = index,
                                        child: Container(
                                          color: provider.winnerIndex == index
                                              ? Colors.blue
                                              : null,
                                          child: Dismissible(
                                            key: Key(provider.players[index]),
                                            onDismissed: (direction) =>
                                                provider.removePlayer(index),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        provider.players[index],
                                                        style:
                                                            provider.winnerIndex ==
                                                                    index
                                                                ? TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  )
                                                                : TextStyle(),
                                                      ),
                                                    ),
                                                  ),
                                                  if (provider.winnerIndex ==
                                                      index)
                                                    Icon(
                                                      Icons
                                                          .emoji_events_rounded,
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
                                  onPressed: () {
                                    Match? newMatch = context
                                        .read<CreateMatchProvider>()
                                        .getModel();
                                    if (newMatch != null) {
                                      if (match == null)
                                        MatchService.addMatch(
                                          newMatch,
                                        ).listen(
                                          (data) => Navigator.of(context).pop(),
                                        );
                                      else {
                                        match.updateValues(newMatch);

                                        MatchService.updateMatch(
                                          match,
                                        ).listen(
                                          (data) => Navigator.of(context).pop(),
                                        );
                                      }
                                    }
                                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
