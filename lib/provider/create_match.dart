import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  int? _winnerIndex;

  CreateMatchProvider({
    required this.players,
  });

  CreateMatchProvider.fromMatch({
    required List<String> playersList,
    String winnerPlayer = "",
  }) {
    players = playersList;
    winnerIndex =
        winnerPlayer.isNotEmpty ? playersList.indexOf(winnerPlayer) : null;
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
    );
  }

  resetProvider() {
    dropdownValueGame = '';
    players = [];
    winnerIndex = null;
    notifyListeners();
  }
}
