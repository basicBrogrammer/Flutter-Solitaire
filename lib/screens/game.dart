import 'package:flutter/material.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/widgets/finished_cards.dart';
import 'package:solitaire/widgets/remaining_cards.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Stores the cards on the seven columns
  List<PlayingCard> cardColumn1 = [];
  List<PlayingCard> cardColumn2 = [];
  List<PlayingCard> cardColumn3 = [];
  List<PlayingCard> cardColumn4 = [];
  List<PlayingCard> cardColumn5 = [];
  List<PlayingCard> cardColumn6 = [];
  List<PlayingCard> cardColumn7 = [];

  // Stores the card deck
  List<PlayingCard> deck = [];
  List<PlayingCard> usedCards = [];

  // Stores the card in the upper boxes
  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: PlayingCard.width * 2.5,
              child: RemainingCards(deck, usedCards),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: PlayingCard.width * 4.5,
              child: FinishedCards(
                finalHeartsDeck,
                finalDiamondsDeck,
                finalSpadesDeck,
                finalClubsDeck,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardColumn(cardColumn1, 0, _moveCards),
            CardColumn(cardColumn2, 1, _moveCards),
            CardColumn(cardColumn3, 2, _moveCards),
            CardColumn(cardColumn4, 3, _moveCards),
            CardColumn(cardColumn5, 4, _moveCards),
            CardColumn(cardColumn6, 5, _moveCards),
            CardColumn(cardColumn7, 6, _moveCards),
          ],
        ),
      ],
    );
  }

  void _initializeGame() {
    setState(() {
      CardSuit.values.forEach((suit) {
        CardType.values.forEach((type) {
          deck.add(PlayingCard(cardSuit: suit, cardType: type));
        });
      });

      deck.shuffle();

      var columnList = _cardColumns();

      columnList.forEach((col) {
        var sublist = deck.sublist(0, columnList.indexOf(col) + 1);
        var lastCard = sublist.removeLast();
        lastCard.faceUp = true;
        col.addAll([...sublist, lastCard]);

        deck.removeRange(0, columnList.indexOf(col) + 1);
      });

      usedCards.add(deck.removeLast()..faceUp = true);
    });
  }

  void _moveCards(List<PlayingCard> cards, int fromIdx, int toIdx) {
    var columns = _cardColumns();
    var from = columns[fromIdx];
    var to = columns[toIdx];

    setState(() {
      from.removeWhere((card) => cards.contains(card));
      to.addAll(cards);
    });
  }

  List<List<PlayingCard>> _cardColumns() {
    return [
      cardColumn1,
      cardColumn2,
      cardColumn3,
      cardColumn4,
      cardColumn5,
      cardColumn6,
      cardColumn7,
    ];
  }
}
