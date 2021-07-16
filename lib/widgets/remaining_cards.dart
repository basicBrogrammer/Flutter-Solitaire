import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/face_down_card.dart';
import 'package:solitaire/widgets/face_up_card.dart';

class RemainingCards extends StatelessWidget {
  final List<PlayingCard> deck;
  final List<PlayingCard> usedCards;

  const RemainingCards(this.deck, this.usedCards);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FaceDownCard(deck.last),
        FaceUpCard(usedCards.last),
      ],
    );
  }
}
