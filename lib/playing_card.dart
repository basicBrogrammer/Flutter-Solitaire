import 'package:flutter/material.dart';

enum CardSuit { spades, hearts, diamonds, clubs }

enum CardType {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
}

class PlayingCard {
  static double layoutGutter = 5.0;
  static double calcWidth(BuildContext context) {
    return (MediaQuery.of(context).size.width - 8 * layoutGutter) / 7;
  }

  static double calcHeight(BuildContext context) {
    return PlayingCard.calcWidth(context) * 1.5;
  }

  static const width = 50.0;
  static const height = 70.0;
  CardSuit suit;
  CardType value;
  bool faceUp;
  bool opened;

  PlayingCard({
    required this.suit,
    required this.value,
    this.faceUp = false,
    this.opened = false,
  });

  Color get cardColor {
    if (suit == CardSuit.hearts || suit == CardSuit.diamonds) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Image get image {
    switch (suit) {
      case CardSuit.clubs:
        return Image.asset('assets/clubs.png');
      case CardSuit.spades:
        return Image.asset('assets/spades.png');
      case CardSuit.diamonds:
        return Image.asset('assets/diamonds.png');
      case CardSuit.hearts:
        return Image.asset('assets/hearts.png');
    }
  }

  String get valueToString {
    switch (value) {
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

  String get inspect {
    return "$suit $value";
  }
}
