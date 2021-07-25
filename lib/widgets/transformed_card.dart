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
  final Animation<double> controller;
  final Animation<double> transform;

  TransformedCard({
    required this.card,
    required this.onDrag,
    required this.onDragEnded,
    required this.controller,
    this.transformIndex = 0,
    this.attachedCards = const [],
    this.colIdx = -1,
  }) : transform = Tween<double>(
          begin: 0.0,
          end: transformIndex * 20.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.linear,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              0.0,
              transform.value,
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
                            controller: controller,
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
      },
    );
  }
}
