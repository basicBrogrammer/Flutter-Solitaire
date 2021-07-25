import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/models/deck.dart';
import 'package:solitaire/playing_card.dart';
import 'package:solitaire/widgets/card_column.dart';
import 'package:solitaire/widgets/display_card.dart';
import 'package:solitaire/widgets/finished_deck.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _reset(DeckModel model) async {
    try {
      await _controller.reverse().orCancel;
      model.reset();
      await _controller.forward().orCancel;
      // await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    const topGutter = 5.0;

    return Consumer<DeckModel>(builder: (context, model, child) {
      var lastUsedCard = model.usedCards.isEmpty ? null : model.usedCards.last;
      var secondFromLastUsedCard = model.usedCards.length > 1
          ? model.usedCards[model.usedCards.length - 2]
          : null;
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              children: [
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 0),
                  child: GestureDetector(
                    onTap: model.draw,
                    behavior: HitTestBehavior.translucent,
                    child: DisplayCard(PlayingCard(
                      suit: CardSuit.spades,
                      value: CardType.ace,
                    )),
                  ),
                ),
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 1),
                  child: model.usedCards.isEmpty
                      ? DisplayCard(null)
                      : Draggable(
                          child: DisplayCard(lastUsedCard),
                          feedback: DisplayCard(lastUsedCard),
                          childWhenDragging:
                              DisplayCard(secondFromLastUsedCard),
                          data: {
                            "cards": [lastUsedCard!],
                            "column": -1
                          },
                        ),
                ),
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 3),
                  child: FinishedDeck(CardSuit.hearts),
                ),
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 4),
                  child: FinishedDeck(CardSuit.spades),
                ),
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 5),
                  child: FinishedDeck(CardSuit.diamonds),
                ),
                Positioned(
                  top: topGutter,
                  left: _columnLeft(context, 6),
                  child: FinishedDeck(CardSuit.clubs),
                ),
                CardColumn(0, _controller.view),
                CardColumn(1, _controller.view),
                CardColumn(2, _controller.view),
                CardColumn(3, _controller.view),
                CardColumn(4, _controller.view),
                CardColumn(5, _controller.view),
                CardColumn(6, _controller.view),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                _reset(model);
              },
              child: Text('New'),
            ),
          ),
        ],
      );
    });
  }

  double _columnLeft(BuildContext context, int idx) {
    return (PlayingCard.calcWidth(context) + PlayingCard.layoutGutter) * idx +
        PlayingCard.layoutGutter;
  }
}
