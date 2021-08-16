import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:boardmate/model/match.dart';

class CreateMatchProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  List<String> players = [];

  String _dropdownValueGame = "";

  String get dropdownValueGame => _dropdownValueGame;

  set dropdownValueGame(String dropdownValueGame) {
    _dropdownValueGame = dropdownValueGame;
    notifyListeners();
  }

  void setDefaultDropdownValue(String id) {
    _dropdownValueGame = id;
  }

  DateTime gameTime = DateTime.now();

  int? _winnerIndex;

  CreateMatchProvider({
    required this.players,
  });

  CreateMatchProvider.fromMatch({
    Match? match,
  }) {
    if (match != null) {
      players = match.players;
      winnerIndex =
          match.winner.isNotEmpty ? players.indexOf(match.winner) : null;
      if (match.timeMatch != null)
        gameTime = DateTime(
          match.timeMatch!.toDate().year,
          match.timeMatch!.toDate().month,
          match.timeMatch!.toDate().day,
          match.timeMatch!.toDate().hour,
          match.timeMatch!.toDate().minute,
        );
    }
  }

  int? get winnerIndex => _winnerIndex;

  set winnerIndex(int? winnerIndex) {
    _winnerIndex = winnerIndex;
    notifyListeners();
  }

  addPlayerToList() {
    if (winnerIndex != null) winnerIndex = winnerIndex! + 1;
    players.insert(0, nameController.text);
    nameController.text = '';
    notifyListeners();
  }

  removePlayer(int index) {
    if (winnerIndex != null) {
      if (index == winnerIndex)
        winnerIndex = null;
      else
        winnerIndex = winnerIndex! - 1;
    }
    players.removeAt(index);
    notifyListeners();
  }

  Match getModel() {
    if (dropdownValueGame.isEmpty || players.isEmpty || winnerIndex == null)
      throw Exception('Something REALY BAD happened');

    return Match(
      id: '',
      gameId: dropdownValueGame,
      players: players,
      winner: players[winnerIndex ?? 0],
      createdAt: Timestamp.now(),
      timeMatch: Timestamp.fromDate(gameTime),
    );
  }

  resetProvider() {
    dropdownValueGame = '';
    players = [];
    winnerIndex = null;
    notifyListeners();
  }

  void setDate(DateTime? value) {
    if (value != null)
      gameTime = DateTime(
        value.year,
        value.month,
        value.day,
        gameTime.hour,
        gameTime.minute,
      );
    else
      gameTime = DateTime.now();

    notifyListeners();
  }

  void setTime(TimeOfDay? value) {
    if (value != null)
      gameTime = DateTime(
        gameTime.year,
        gameTime.month,
        gameTime.day,
        value.hour,
        value.minute,
      );

    notifyListeners();
  }
}
