import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  String totalTime;

  _MemoryGameComponentState() {
    buildCards();
  }

  TextStyle defaultTextStile = TextStyle(
    color: Colors.grey.shade900,
    fontWeight: FontWeight.w500,
    fontSize: 21,
  );

  @override
  void initState() {
    super.initState();
    this.newGame();
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
    this.cards.shuffle();

    this.flippedCards = [];

    this.couples = 0;

    this.onPlay = false;

    this.firstMove = true;

    setState(() {
      this.endGame = false;

      this.cards.forEach((element) {
        element.flipped = false;
      });
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

              int totalTimeInSeconds =
                  (endDate.difference(startDate).inSeconds);

              totalTime = totalTimeInSeconds > 60
                  ? 'Fez em ' + formatDuration(totalTimeInSeconds) + ' minutos'
                  : 'Fez em ' + totalTimeInSeconds.toString() + ' segundos';

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

  String formatDuration(int totalTimeInSeconds) {
    (Duration(seconds: totalTimeInSeconds)).toString();

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(
        Duration(seconds: totalTimeInSeconds).inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(
        Duration(seconds: totalTimeInSeconds).inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Styles.mainBackgroundColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              // margin: EdgeInsets.all(20),
              child: GridView.count(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                crossAxisCount: 3,
                children: cards.map((item) => _createTile(item)).toList(),
              ),
            ),
            this.endGame
                ? Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white.withOpacity(0.9),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height) / 3),
                      // width: 100,
                      // height: 100,
                      // alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Boa!',
                              style: defaultTextStile,
                            ),
                          ),
                          Text(
                            totalTime,
                            style: defaultTextStile,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 40,
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: ButtonTheme(
                              minWidth: 200,
                              height: 60.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: Styles.defaultBorderRadius,
                                ),
                                onPressed: () {
                                  this.newGame();
                                },
                                color: Colors.deepPurple,
                                child: Text(
                                  'Novo jogo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : new Container(),
          ],
        ),
      ),
    );
  }
}
