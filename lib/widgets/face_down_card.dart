import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';

class FaceDownCard extends StatelessWidget {
  final PlayingCard card;
  const FaceDownCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
