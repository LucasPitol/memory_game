import 'package:flutter/material.dart';

import 'models/memory_card.dart';
import 'utils/styles.dart';

class MemoryGameComponent extends StatefulWidget {
  @override
  _MemoryGameComponentState createState() => _MemoryGameComponentState();
}

class _MemoryGameComponentState extends State<MemoryGameComponent> {
  List<CardMemory> cards;

  _MemoryGameComponentState() {
    buildCards();
    newGame();
  }

  buildCards() {
    this.cards = [];

    this.cards.add(CardMemory(1, Icons.cloud_queue));
    this.cards.add(CardMemory(2, Icons.cloud_queue));

    this.cards.add(CardMemory(3, Icons.code));
    this.cards.add(CardMemory(4, Icons.code));

    this.cards.add(CardMemory(5, Icons.attach_money));
    this.cards.add(CardMemory(6, Icons.attach_money));

    this.cards.add(CardMemory(7, Icons.local_bar));
    this.cards.add(CardMemory(8, Icons.local_bar));

    this.cards.add(CardMemory(9, Icons.fingerprint));
    this.cards.add(CardMemory(10, Icons.fingerprint));
  }

  newGame() {
    // this.shuffleCards()

    // this.cardsFlipped = [];

    // this.couples = 0;

    // this.endGame = false;

    // this.onPLay = false;

    // this.firstMove = true;

    this.cards.forEach((element) {
      element.flipped = false;
    });
  }

  flipCard(int cardId) {}

  Widget _createTile(CardMemory card) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 5),
        decoration: Styles.card,
        width: 70,
        height: 100,
        child: Material(
          borderRadius: Styles.defaultBorderRadius,
          color: Colors.white,
          child: InkWell(
            borderRadius: Styles.defaultBorderRadius,
            splashColor: Colors.deepPurple.shade100,
            onTap: () {
              this.flipCard(card.id);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50),
          // margin: EdgeInsets.all(20),
          child: GridView.count(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            crossAxisCount: 3,
            children: cards.map((item) => _createTile(item)).toList(),
          ),
        ),
      ),
    );
  }
}
