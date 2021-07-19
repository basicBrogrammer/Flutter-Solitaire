import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class RemainingCards extends StatelessWidget {
  final List<PlayingCard> deck;
  final List<PlayingCard> usedCards;
  final void Function() drawCard;

  const RemainingCards(this.deck, this.usedCards, this.drawCard);

  @override
  Widget build(BuildContext context) {
    var lastUsedCard = usedCards.isEmpty ? null : usedCards.last;
    var secondFromLastUsedCard =
        usedCards.length > 1 ? usedCards[usedCards.length - 2] : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: drawCard,
          behavior: HitTestBehavior.translucent,
          child: DisplayCard(deck.length > 0 ? deck.first : null),
        ),
        usedCards.isEmpty
            ? DisplayCard(null)
            : Draggable(
                child: DisplayCard(lastUsedCard),
                feedback: DisplayCard(lastUsedCard),
                childWhenDragging: DisplayCard(secondFromLastUsedCard),
                data: {
                  "cards": [lastUsedCard!],
                  "column": -1
                },
              ),
      ],
    );
  }
}
