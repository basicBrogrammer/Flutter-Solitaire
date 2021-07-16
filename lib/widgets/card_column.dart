import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/transformed_card.dart';

class CardColumn extends StatelessWidget {
  final List<PlayingCard> cards;
  const CardColumn(this.cards);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 13 * 15,
        width: 70,
        margin: EdgeInsets.all(2),
        child: Stack(
          children: cards
              .map((card) => TransformedCard(
                    card: card,
                    transformIndex: cards.indexOf(card),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
