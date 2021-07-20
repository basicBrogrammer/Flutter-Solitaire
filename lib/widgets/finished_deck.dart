import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class FinishedDeck extends StatelessWidget {
  final List<PlayingCard> cards;
  final CardSuit suit;
  final Function(PlayingCard card, int fromIdx, CardSuit suit) retireCard;
  const FinishedDeck(
      {required this.cards, required this.suit, required this.retireCard});

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return cards.isEmpty ? _emptyPile() : DisplayCard(cards.last);
      },
      onAccept: (Map payload) {
        List<PlayingCard> draggedCards = payload["cards"] as List<PlayingCard>;
        retireCard(draggedCards.first, payload['column'], suit);
      },
      onWillAccept: (value) {
        List<PlayingCard> draggedCards = (value as Map)["cards"];
        // dragging too many cards or it is the wrong suit
        if (draggedCards.length > 1 || suit != draggedCards.last.suit) {
          return false;
        } else {
          return cards.isEmpty ||
              draggedCards.last.value.index - cards.last.value.index == 1;
        }
      },
    );
  }

  Widget _emptyPile() {
    return Opacity(
      opacity: 0.6,
      child: Container(
        height: PlayingCard.height,
        width: PlayingCard.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          height: 20.0,
          width: 20.0,
          padding: EdgeInsets.all(8),
          child: Image.asset('assets/$suitToString.png'),
        ),
      ),
    );
  }

  String get suitToString {
    switch (suit) {
      case CardSuit.hearts:
        return 'hearts';
      case CardSuit.diamonds:
        return 'diamonds';
      case CardSuit.clubs:
        return 'clubs';
      case CardSuit.spades:
        return 'spades';
    }
  }
}
