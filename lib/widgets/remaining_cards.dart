import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class RemainingCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DeckModel>(builder: (context, model, child) {
      var lastUsedCard = model.usedCards.isEmpty ? null : model.usedCards.last;
      var secondFromLastUsedCard = model.usedCards.length > 1
          ? model.usedCards[model.usedCards.length - 2]
          : null;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: model.draw,
            behavior: HitTestBehavior.translucent,
            child: DisplayCard(
                PlayingCard(suit: CardSuit.spades, value: CardType.ace)),
          ),
          model.usedCards.isEmpty
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
    });
  }
}
