import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';

// For now I'm going to put all the state into a single Model.
// I'm hopping to swing back around to break these up into multiple context, but
// currently I don't see an easy way to move data from one context to another.
// To Be Continued....
class DeckModel extends ChangeNotifier {
  // Stores the cards on the seven columns
  List<PlayingCard> _cardColumn1 = [];
  List<PlayingCard> _cardColumn2 = [];
  List<PlayingCard> _cardColumn3 = [];
  List<PlayingCard> _cardColumn4 = [];
  List<PlayingCard> _cardColumn5 = [];
  List<PlayingCard> _cardColumn6 = [];
  List<PlayingCard> _cardColumn7 = [];

  UnmodifiableListView<PlayingCard> get cardColumn1 =>
      UnmodifiableListView(_cardColumn1);
  UnmodifiableListView<PlayingCard> get cardColumn2 =>
      UnmodifiableListView(_cardColumn2);
  UnmodifiableListView<PlayingCard> get cardColumn3 =>
      UnmodifiableListView(_cardColumn3);
  UnmodifiableListView<PlayingCard> get cardColumn4 =>
      UnmodifiableListView(_cardColumn4);
  UnmodifiableListView<PlayingCard> get cardColumn5 =>
      UnmodifiableListView(_cardColumn5);
  UnmodifiableListView<PlayingCard> get cardColumn6 =>
      UnmodifiableListView(_cardColumn6);
  UnmodifiableListView<PlayingCard> get cardColumn7 =>
      UnmodifiableListView(_cardColumn7);
  List<UnmodifiableListView<PlayingCard>> get cardColumns => [
        cardColumn1,
        cardColumn2,
        cardColumn3,
        cardColumn4,
        cardColumn5,
        cardColumn6,
        cardColumn7
      ];

  UnmodifiableListView<PlayingCard> getColumn(int idx) {
    print('getColumn $idx');
    return cardColumns.elementAt(idx);
  }

  // Stores the card deck
  List<PlayingCard> _deck = [];
  List<PlayingCard> _usedCards = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<PlayingCard> get deck => UnmodifiableListView(_deck);
  UnmodifiableListView<PlayingCard> get usedCards =>
      UnmodifiableListView(_usedCards);

  // Stores the card in the upper boxes
  List<PlayingCard> _finalHeartsDeck = [];
  List<PlayingCard> _finalDiamondsDeck = [];
  List<PlayingCard> _finalSpadesDeck = [];
  List<PlayingCard> _finalClubsDeck = [];
  UnmodifiableListView<PlayingCard> finalDeck(CardSuit suit) =>
      UnmodifiableListView(_finalDeck(suit));

  void reset() {
    print('Reseting....');
    _deck = [];
    _usedCards = [];
    _cardColumn1 = [];
    _cardColumn2 = [];
    _cardColumn3 = [];
    _cardColumn4 = [];
    _cardColumn5 = [];
    _cardColumn6 = [];
    _cardColumn7 = [];
    _finalHeartsDeck = [];
    _finalDiamondsDeck = [];
    _finalSpadesDeck = [];
    _finalClubsDeck = [];

    deal();
    notifyListeners();
  }

  void deal() {
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        _deck.add(PlayingCard(suit: suit, value: type));
      });
    });

    _deck.shuffle();

    _cardColumns.forEach((col) {
      var sublist = _deck.sublist(0, _cardColumns.indexOf(col) + 1);
      var lastCard = sublist.removeLast();
      lastCard.faceUp = true;
      col.addAll([...sublist, lastCard]);

      _deck.removeRange(0, _cardColumns.indexOf(col) + 1);
    });

    notifyListeners();
  }

  void draw() {
    if (_deck.length > 0) {
      var newCard = _deck.removeLast();
      newCard.faceUp = true;
      _usedCards.add(newCard);
    } else {
      _deck = usedCards.map((card) {
        card.faceUp = false;
        return card;
      }).toList();
      _usedCards = [];
    }
    notifyListeners();
  }

  void moveCards(List<PlayingCard> cards, int fromIdx, int toIdx) {
    var to = _cardColumns[toIdx];

    if (fromIdx == -1) {
      to.add(_usedCards.removeLast());
    } else {
      var from = _cardColumns[fromIdx];

      from.removeWhere((card) => cards.contains(card));
      if (from.length > 0 && !from.last.faceUp) {
        from.last.faceUp = true;
      }
      to.addAll(cards);
    }

    notifyListeners();
  }

  void retireCard(PlayingCard card, int fromIdx, CardSuit suit) {
    var finalDeck = _finalDeck(suit);
    if (fromIdx == -1) {
      finalDeck.add(_usedCards.removeLast());
    } else {
      var from = _cardColumns[fromIdx];
      finalDeck.add(from.removeLast());
      if (from.length > 0 && !from.last.faceUp) {
        from.last.faceUp = true;
      }
    }

    notifyListeners();
  }

  List<PlayingCard> _finalDeck(CardSuit suit) {
    switch (suit) {
      case CardSuit.hearts:
        return _finalHeartsDeck;
      case CardSuit.diamonds:
        return _finalDiamondsDeck;
      case CardSuit.clubs:
        return _finalClubsDeck;
      case CardSuit.spades:
        return _finalSpadesDeck;
    }
  }

  void useCard(PlayingCard card) {
    _usedCards.remove(card);

    notifyListeners();
  }

  List<List<PlayingCard>> get _cardColumns {
    return [
      _cardColumn1,
      _cardColumn2,
      _cardColumn3,
      _cardColumn4,
      _cardColumn5,
      _cardColumn6,
      _cardColumn7,
    ];
  }
}
