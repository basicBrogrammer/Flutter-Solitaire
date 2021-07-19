import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';

class DisplayCard extends StatelessWidget {
  final PlayingCard? card;
  const DisplayCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PlayingCard.height,
      width: PlayingCard.width,
      decoration: BoxDecoration(
        color: backgroundColor(),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _buildChild(),
    );
  }

  Color backgroundColor() {
    if (card is PlayingCard) {
      if (card!.faceUp) {
        return Colors.white;
      } else {
        return Colors.blue;
      }
    } else {
      return Colors.transparent;
    }
  }

  Widget? _buildChild() {
    if (card is PlayingCard && card!.faceUp) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Text(
              card!.valueToString,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 10.0,
            width: 10.0,
            child: card!.image,
          ),
        ],
      );
    } else {
      return null;
    }
  }
}
