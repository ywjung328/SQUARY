import 'package:flutter/material.dart';

enum Position { START, CENTER, END }

class ImageDataProvider extends ChangeNotifier {
  Color backgroundColor = Colors.white;
  Position imgPosition = Position.CENTER;

  getColor() => backgroundColor;
  setColor(Color color) {
    backgroundColor = color;
    notifyListeners();
  }

  getPosition() => imgPosition;
  setPosition(Position position) {
    imgPosition = position;
    notifyListeners();
  }
}
