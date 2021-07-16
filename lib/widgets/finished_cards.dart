import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';

class FinishedCards extends StatelessWidget {
  final List<PlayingCard> finalHeartsDeck;
  final List<PlayingCard> finalDiamondsDeck;
  final List<PlayingCard> finalSpadesDeck;
  final List<PlayingCard> finalClubsDeck;
  const FinishedCards(
    this.finalHeartsDeck,
    this.finalDiamondsDeck,
    this.finalSpadesDeck,
    this.finalClubsDeck,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildEmptyContainer('hearts'),
        _buildEmptyContainer('spades'),
        _buildEmptyContainer('diamonds'),
        _buildEmptyContainer('clubs'),
      ],
    );
  }

  Widget _buildEmptyContainer(String image) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        height: PlayingCard.height,
        width: PlayingCard.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          height: 20.0,
          width: 20.0,
          padding: EdgeInsets.all(8),
          child: Image.asset('assets/$image.png'),
        ),
      ),
    );
  }
}
