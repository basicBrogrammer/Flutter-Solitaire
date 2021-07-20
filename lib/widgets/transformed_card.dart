import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/display_card.dart';

class TransformedCard extends StatelessWidget {
  final PlayingCard card;
  final int transformIndex;
  final int colIdx;
  final List<PlayingCard> attachedCards;
  final Function(PlayingCard) onDrag;
  final Function() onDragEnded;

  const TransformedCard({
    required this.card,
    required this.onDrag,
    required this.onDragEnded,
    this.transformIndex = 0,
    this.attachedCards = const [],
    this.colIdx = -1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          0.0,
          transformIndex * 20.0,
          0.0,
        ),
      child: card.faceUp
          ? Draggable(
              hitTestBehavior: HitTestBehavior.opaque,
              child: DisplayCard(card),
              feedback: Stack(
                children: attachedCards
                    .map(
                      (attachedCard) => TransformedCard(
                        card: attachedCard,
                        transformIndex: attachedCards.indexOf(attachedCard),
                        onDrag: (PlayingCard _) {},
                        onDragEnded: () {},
                      ),
                    )
                    .toList(),
              ), // this should be attached cards
              childWhenDragging: Container(),
              data: {"cards": attachedCards, "column": colIdx},
              onDragStarted: () {
                onDrag(card);
              },
              onDraggableCanceled: (_, __) {
                onDragEnded();
              },
              onDragCompleted: () {
                onDragEnded();
              },
            )
          : DisplayCard(card),
    );
  }
}
