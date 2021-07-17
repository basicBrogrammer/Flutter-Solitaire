import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/transformed_card.dart';

class CardColumn extends StatelessWidget {
  final List<PlayingCard> cards;
  final int idx;
  final void Function(List<PlayingCard>, int, int) moveCard;
  CardColumn(this.cards, this.idx, this.moveCard);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DragTarget(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          height: 13 * 15, // can this be a function of PlayingCard height
          width: PlayingCard.width,
          margin: EdgeInsets.all(2),
          child: Stack(
            children: cards
                .map((card) => TransformedCard(
                      card: card,
                      transformIndex: cards.indexOf(card),
                      attachedCards: cards.sublist(cards.indexOf(card)),
                      colIdx: idx,
                    ))
                .toList(),
          ),
        );
      },
      onAccept: (Map payload) {
        moveCard(payload['cards'], payload['column'], idx);
      },
      onWillAccept: (value) {
        if (cards.length == 0) {
          return true;
        }

        List<PlayingCard> draggedCards = (value as Map)["cards"];

        var bottomCard = cards.last;
        var incomingCard = draggedCards.first;

        return bottomCard.cardColor != incomingCard.cardColor &&
            bottomCard.cardType.index - incomingCard.cardType.index == 1;
      },
    ));
  }
}
