import 'package:boardmate/model/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map> _gameCollection =
    FirebaseFirestore.instance.collection('game');

class GameService {
  static Stream<DocumentReference<Map>> addGame(Game game) {
    return _gameCollection.add(game.toMap()).asStream();
  }

  static Stream<Game> getGame(String id) {
    return _gameCollection
        .doc(id)
        .snapshots()
        .map((event) => Game.fromFirestore(event));
  }

  static Stream<List<Game>> getAllGames() {
    return _gameCollection.orderBy('name').snapshots().map(
          (event) => event.docs
              .map(
                (e) => Game.fromFirestore(e),
              )
              .toList(),
        );
  }

  static void gamePlayed(Game game) {
    game.timesPlayed++;

    _gameCollection.doc(game.id).update({
      'times_played': game.timesPlayed,
    });
  }
}
