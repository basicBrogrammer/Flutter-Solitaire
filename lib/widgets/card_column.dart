import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/transformed_card.dart';
import 'dart:math';

class CardColumn extends StatefulWidget {
  final List<PlayingCard> cards;
  final int idx;
  final void Function(List<PlayingCard>, int, int) moveCard;
  CardColumn(this.cards, this.idx, this.moveCard);

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  int dragCardIndex = 100;
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
              children: widget.cards
                  .map((card) => TransformedCard(
                        card: card,
                        transformIndex: widget.cards.indexOf(card),
                        attachedCards:
                            widget.cards.sublist(widget.cards.indexOf(card)),
                        colIdx: widget.idx,
                        onDrag: onDrag,
                        onDragEnded: () {
                          setState(() {
                            dragCardIndex = 100;
                          });
                        },
                      ))
                  .toList()
                  .sublist(0, min(widget.cards.length, dragCardIndex)),
            ),
          );
        },
        onAccept: (Map payload) {
          widget.moveCard(payload['cards'], payload['column'], widget.idx);
          setState(() {
            dragCardIndex = 100;
          });
        },
        onWillAccept: (value) {
          if (widget.cards.length == 0) {
            return true;
          }

          List<PlayingCard> draggedCards = (value as Map)["cards"];

          var bottomCard = widget.cards.last;
          var incomingCard = draggedCards.first;

          return bottomCard.cardColor != incomingCard.cardColor &&
              bottomCard.value.index - incomingCard.value.index == 1;
        },
      ),
    );
  }

  void onDrag(PlayingCard card) {
    setState(() {
      dragCardIndex = widget.cards.indexOf(card);
    });
  }
}
