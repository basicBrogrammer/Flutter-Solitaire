import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/transformed_card.dart';
import 'dart:math';

class CardColumn extends StatefulWidget {
  final int idx;
  CardColumn(this.idx);

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  int dragCardIndex = 100;
  @override
  Widget build(BuildContext context) {
    return Consumer<DeckModel>(builder: (context, model, child) {
      var cards = model.getColumn(widget.idx);

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
                child: Consumer<DeckModel>(
                  builder: (context, model, child) {
                    var cards = model.getColumn(widget.idx);
                    return Stack(
                      children: cards
                          .map((card) => TransformedCard(
                                card: card,
                                transformIndex: cards.indexOf(card),
                                attachedCards:
                                    cards.sublist(cards.indexOf(card)),
                                colIdx: widget.idx,
                                onDrag: (PlayingCard dragonCard) {
                                  setState(() {
                                    dragCardIndex = cards.indexOf(dragonCard);
                                  });
                                },
                                onDragEnded: () {
                                  setState(() {
                                    dragCardIndex = 100;
                                  });
                                },
                              ))
                          .toList()
                          .sublist(0, min(cards.length, dragCardIndex)),
                    );
                  },
                ));
          },
          onAccept: (Map payload) {
            model.moveCards(payload['cards'], payload['column'], widget.idx);
            setState(() {
              dragCardIndex = 100;
            });
          },
          onWillAccept: (value) {
            if (cards.length == 0) {
              return true;
            }

            List<PlayingCard> draggedCards = (value as Map)["cards"];

            var bottomCard = cards.last;
            var incomingCard = draggedCards.first;

            return bottomCard.cardColor != incomingCard.cardColor &&
                bottomCard.value.index - incomingCard.value.index == 1;
          },
        ),
      );
    });
  }
}
