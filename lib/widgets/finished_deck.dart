import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class FinishedDeck extends StatelessWidget {
  final CardSuit suit;
  const FinishedDeck(this.suit);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeckModel>(builder: (context, model, child) {
      var cards = model.finalDeck(suit);
      return DragTarget(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return cards.isEmpty ? _emptyPile(context) : DisplayCard(cards.last);
        },
        onAccept: (Map payload) {
          List<PlayingCard> draggedCards =
              payload["cards"] as List<PlayingCard>;
          model.retireCard(draggedCards.first, payload['column'], suit);
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
    });
  }

  Widget _emptyPile(context) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        height: PlayingCard.calcHeight(context),
        width: PlayingCard.calcWidth(context),
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
