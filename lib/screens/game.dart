import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/widgets/finished_deck.dart';
import 'package:solitaire/widgets/remaining_cards.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: PlayingCard.height / 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              width: PlayingCard.width * 2.5,
              child: RemainingCards(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: PlayingCard.width * 4.5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FinishedDeck(CardSuit.hearts),
                  FinishedDeck(CardSuit.spades),
                  FinishedDeck(CardSuit.diamonds),
                  FinishedDeck(CardSuit.clubs),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: PlayingCard.height / 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardColumn(0),
            CardColumn(1),
            CardColumn(2),
            CardColumn(3),
            CardColumn(4),
            CardColumn(5),
            CardColumn(6),
          ],
        ),
        Consumer<DeckModel>(
          builder: (context, model, child) {
            return ElevatedButton(onPressed: model.reset, child: Text('New'));
          },
        )
      ],
    );
  }
}
