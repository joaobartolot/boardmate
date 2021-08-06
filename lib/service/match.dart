import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boardmate/model/match.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference<Map> _matchCollection =
    FirebaseFirestore.instance.collection('match');

class MatchService {
  static Stream<DocumentReference<Map>> addMatch(Match match) {
    return _matchCollection.add(match.toMap()).asStream();
  }

  static Stream<Match> getMatch(String id) {
    return _matchCollection
        .doc(id)
        .snapshots()
        .map((event) => Match.fromFirestore(event));
  }

  static Stream<List<Match>> getAllMatches() {
    return _matchCollection
        .orderBy('createdAt', descending: true)
        .where('userUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Match.fromFirestore(e)).toList());
  }

  static Stream<List<String>> getMatchesIds() {
    return _matchCollection
        .orderBy('createdAt', descending: true)
        .where('userUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map((e) => e.id).toList());
  }

  static Future<void> deleteMatch(String id) async {
    await _matchCollection.doc(id).delete();
  }
}
