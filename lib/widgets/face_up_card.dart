import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';

class FaceUpCard extends StatelessWidget {
  final PlayingCard card;
  const FaceUpCard(this.card);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: 60,
        width: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  _cardTypeToString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                height: 10.0,
                width: 10.0,
                child: _cardSuitImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // method that converts the CardType to a string
  String _cardTypeToString() {
    switch (card.cardType) {
      case CardType.ace:
        return 'A';
      case CardType.king:
        return 'K';
      case CardType.queen:
        return 'Q';
      case CardType.jack:
        return 'J';
      case CardType.ten:
        return '10';
      case CardType.nine:
        return '9';
      case CardType.eight:
        return '8';
      case CardType.seven:
        return '7';
      case CardType.six:
        return '6';
      case CardType.five:
        return '5';
      case CardType.four:
        return '4';
      case CardType.three:
        return '3';
      case CardType.two:
        return '2';
      default:
        return '?';
    }
  }

  Image? _cardSuitImage() {
    switch (card.cardSuit) {
      case CardSuit.clubs:
        return Image.asset('assets/clubs.png');
      case CardSuit.spades:
        return Image.asset('assets/spades.png');
      case CardSuit.diamonds:
        return Image.asset('assets/diamonds.png');
      case CardSuit.hearts:
        return Image.asset('assets/hearts.png');
      default:
        return null;
    }
  }
}
