import 'package:boardmate/model/match.dart';
import 'package:flutter/foundation.dart';

class MatchCardProvider extends ChangeNotifier {
  late Match match;

  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  set isExpanded(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  MatchCardProvider(Match match) {
    this.match = match;
  }
}
