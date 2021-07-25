import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/transformed_card.dart';
import 'dart:math';

class CardColumn extends StatefulWidget {
  CardColumn(this.idx, this.controller);

  final int idx;
  final Animation<double> controller;
  // final Animation<double> opacity;

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  int dragCardIndex = 100;
  @override
  Widget build(BuildContext context) {
    return Consumer<DeckModel>(builder: (context, model, child) {
      var cards = model.getColumn(widget.idx);
      Size cardSize = Size(50, 100);

      return PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
              Rect.fromLTWH(
                0,
                0,
                PlayingCard.calcWidth(context),
                PlayingCard.calcHeight(context),
              ),
              cardSize),
          end: RelativeRect.fromSize(
              Rect.fromLTWH(
                _columnLeft(context, widget.idx),
                PlayingCard.calcHeight(context) * 1.5,
                PlayingCard.calcWidth(context),
                PlayingCard.calcHeight(context),
              ),
              cardSize),
        ).animate(CurvedAnimation(
          parent: widget.controller,
          curve: Curves.easeInOutSine,
        )),
        child: DragTarget(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
                height: PlayingCard.calcHeight(context) *
                    4.5, // can this be a function of PlayingCard height
                width: PlayingCard.calcWidth(context),
                margin: EdgeInsets.all(2),
                child: Consumer<DeckModel>(
                  builder: (context, model, child) {
                    var cards = model.getColumn(widget.idx);
                    return Stack(
                      children: cards
                          .map((card) => TransformedCard(
                                card: card,
                                controller: widget.controller,
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

  double _columnLeft(BuildContext context, int idx) {
    return (PlayingCard.calcWidth(context) + PlayingCard.layoutGutter) * idx +
        PlayingCard.layoutGutter;
  }
}
