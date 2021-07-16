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
        InkWell(
          child: Opacity(
            opacity: 0.4,
            child: FaceDownCard(deck.last),
          ),
        ),
        InkWell(
          child: Opacity(
            opacity: 0.4,
            child: FaceUpCard(usedCards.last),
          ),
        )
      ],
    );
  }
}