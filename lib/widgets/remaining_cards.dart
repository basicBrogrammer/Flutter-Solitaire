import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class RemainingCards extends StatelessWidget {
  final List<PlayingCard> deck;
  final List<PlayingCard> usedCards;

  const RemainingCards(this.deck, this.usedCards);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DisplayCard(deck.length > 0 ? deck.first : null),
        DisplayCard(usedCards.length > 0 ? usedCards.first : null),
      ],
    );
  }
}
