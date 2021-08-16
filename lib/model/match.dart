import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Match {
  final String id;
  String? userUid;
  String gameId;
  List<String> players;
  String winner;
  Timestamp createdAt;
  Timestamp? timeMatch;

  Match({
    required this.id,
    userUid,
    required this.gameId,
    required this.players,
    required this.winner,
    required this.createdAt,
    this.timeMatch,
  });

  factory Match.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data =
        doc.data() != null ? doc.data() as Map<String, dynamic> : Map();
    List<String> players =
        (data['players'] as List<dynamic>).map((e) => e.toString()).toList();
    return Match(
      id: doc.id,
      userUid: data['userUid'],
      gameId: data['gameId'] ?? '',
      players: players,
      winner: data['winner'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      timeMatch: data['timeMatch'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userUid': this.userUid != null
          ? this.userUid
          : FirebaseAuth.instance.currentUser!.uid,
      'gameId': this.gameId,
      'players': this.players,
      'winner': this.winner,
      'createdAt': this.createdAt,
      'timeMatch': this.timeMatch,
    };
  }

  String playersToString() {
    String playersStr = "";

    for (int i = 0; i < players.length; i++) {
      playersStr += players[i];

      if (i != players.length - 1) {
        playersStr += ", ";
      }
    }

    return playersStr;
  }

  void updateValues(Match newMatch) {
    players = newMatch.players;
    winner = newMatch.winner;
    gameId = newMatch.gameId;
    timeMatch = newMatch.timeMatch;
  }
}
