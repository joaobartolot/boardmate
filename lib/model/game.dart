import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  final String id;
  String name;
  int timesPlayed;

  Game({
    required this.id,
    required this.name,
    required this.timesPlayed,
  });

  factory Game.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data =
        doc.data() != null ? doc.data() as Map<String, dynamic> : Map();
    return Game(
      id: doc.id,
      name: data['name'] ?? '',
      timesPlayed: data['timesPlayed'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'timesPlayed': this.timesPlayed,
    };
  }
}
