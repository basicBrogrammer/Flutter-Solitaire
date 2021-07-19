import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class TransformedCard extends StatelessWidget {
  final PlayingCard card;
  final double transformDistance;
  final int transformIndex;
  final int? colIdx;
  final List<PlayingCard> attachedCards;

  const TransformedCard({
    required this.card,
    this.transformDistance = 20.0,
    this.transformIndex = 0,
    this.attachedCards = const [],
    this.colIdx,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          0.0,
          transformIndex * transformDistance,
          0.0,
        ),
      child: Draggable(
        child: DisplayCard(card),
        feedback: DisplayCard(card), // this should be attached cards
        childWhenDragging: Container(),
        data: {"cards": attachedCards, "column": colIdx},
      ),
    );
  }
}
