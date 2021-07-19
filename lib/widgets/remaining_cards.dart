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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: drawCard,
          behavior: HitTestBehavior.translucent,
          child: DisplayCard(deck.length > 0 ? deck.first : null),
        ),
        DisplayCard(usedCards.length > 0 ? usedCards.last : null),
      ],
    );
  }
}
