import 'package:flutter/material.dart';

class CardMemory {
  int id;
  bool flipped;
  IconData cardContent;

  CardMemory(int id, IconData icon) {
    this.id = id;
    this.cardContent = icon;
    this.flipped = false;
  }
}