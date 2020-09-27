import 'package:flutter/material.dart';

class MemoryGameComponent extends StatefulWidget {
  @override
  _MemoryGameComponentState createState() => _MemoryGameComponentState();
}

class _MemoryGameComponentState extends State<MemoryGameComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Text('Game aqui'),
        ),
      ),
    );
  }
}
