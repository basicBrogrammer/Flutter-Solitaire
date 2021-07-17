import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/face_down_card.dart';
import 'package:solitaire/widgets/face_up_card.dart';

class TransformedCard extends StatelessWidget {
  final PlayingCard card;
  final double transformDistance;
  final int transformIndex;
  final int? colIdx;
  final List<PlayingCard> attachedCards;

  const TransformedCard({
    required this.card,
    this.transformDistance = 15.0,
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
      child: card.faceUp
          ? FaceUpCard(card, attachedCards, colIdx)
          : FaceDownCard(card),
    );
  }
}
