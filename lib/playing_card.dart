enum CardSuit { spades, hearts, diamonds, clubs }

enum CardType {
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
  ace
}

enum CardColor {
  red,
  black,
}

class PlayingCard {
  static const width = 40.0;
  static const height = 60.0;
  CardSuit cardSuit;
  CardType cardType;
  bool faceUp;
  bool opened;

  PlayingCard({
    required this.cardSuit,
    required this.cardType,
    this.faceUp = false,
    this.opened = false,
  });

  CardColor get cardColor {
    if (cardSuit == CardSuit.hearts || cardSuit == CardSuit.diamonds) {
      return CardColor.red;
    } else {
      return CardColor.black;
    }
  }
}
