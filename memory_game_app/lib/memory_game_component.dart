import 'dart:async';

import 'package:flutter/material.dart';

import 'models/memory_card.dart';
import 'utils/styles.dart';

class MemoryGameComponent extends StatefulWidget {
  @override
  _MemoryGameComponentState createState() => _MemoryGameComponentState();
}

class _MemoryGameComponentState extends State<MemoryGameComponent> {
  List<CardMemory> cards;
  List<int> flippedCards;
  bool firstMove;
  bool onPlay;
  bool endGame;
  int couples;
  DateTime startDate;
  DateTime endDate;
  DateTime totalTime;

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
    // this.shuffleCards();

    this.flippedCards = [];

    this.couples = 0;

    this.endGame = false;

    this.onPlay = false;

    this.firstMove = true;

    this.cards.forEach((element) {
      element.flipped = false;
    });
  }

  flipCard(CardMemory card) {
    if (this.firstMove) {
      this.startDate = DateTime.now();

      this.firstMove = false;
    }

    if (!this.onPlay) {
      this.onPlay = true;

      if (!card.flipped) {
        setState(() {
          card.flipped = true;
        });

        this.flippedCards.add(card.id);

        if (this.flippedCards.length >= 2) {
          var previousCardId;

          this.flippedCards.forEach((element) {
            if (element != card.id) {
              previousCardId = element;
            }
          });

          var previousCard =
              this.cards.where((element) => element.id == previousCardId).first;

          if (previousCard.cardContent == card.cardContent) {
            this.couples++;

            if (this.couples >= 5) {
              this.endDate = DateTime.now();
              // this.totalTime = DateTime(this.endDate.getTime() - this.startDate.getTime())

              setState(() {
                this.endGame = true;
              });
            }

            this.flippedCards = [];

            this.onPlay = false;
          } else {
            Timer(const Duration(milliseconds: 1000), () {
              this.flipCouples();
            });
          }
        }
      }
      if (this.flippedCards.length <= 1) {
        this.onPlay = false;
      }
    }
  }

  flipCouples() {
    this.cards.forEach((element) {
      if (this.flippedCards.contains(element.id)) {
        setState(() {
          element.flipped = false;
        });
      }
    });
    this.flippedCards = [];

    this.onPlay = false;
  }

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
              this.flipCard(card);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: card.flipped
                  ? Icon(
                      card.cardContent,
                      size: 35,
                      color: Colors.deepPurple,
                    )
                  : Image.asset(
                      'assets/images/iconx.png',
                      width: 24,
                    ),
            ),
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
