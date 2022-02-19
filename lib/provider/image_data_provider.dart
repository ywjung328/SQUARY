import 'dart:typed_data';

import 'package:flutter/material.dart';

enum Position { START, CENTER, END }

class ImageDataProvider extends ChangeNotifier {
  Color _backgroundColor = Colors.white;
  Position _imgPosition = Position.CENTER;
  bool _isPicked = false;
  bool _isLoading = false;
  String _name = "EMPTY NAME";
  Uint8List _data = Uint8List.fromList([]);
  bool _isVertical = false;
  // bool _backgroundAsImage = false;
  bool _backgroundAsImage = true;
  double _blurRadius = 5;
  double _opacity = 0.5;

  resetSourceImage() {
    _isPicked = false;
    _isLoading = false;
    _name = "EMPTY NAME";
    _data = Uint8List.fromList([]);
    notifyListeners();
  }

  getColor() => _backgroundColor;

  setColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  getPosition() => _imgPosition;

  setPosition(Position position) {
    _imgPosition = position;
    notifyListeners();
  }

  getisPicked() => _isPicked;

  setPicked(bool isPicked) {
    _isPicked = isPicked;
    notifyListeners();
  }

  getLoading() => _isLoading;

  setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  getName() => _name;

  setName(String name) {
    _name = name;
    notifyListeners();
  }

  getByteData() => _data;

  setByteData(Uint8List data) {
    _data = data;
    notifyListeners();
  }

  getIsVertical() => _isVertical;

  setIsVertical(bool isVertical) {
    _isVertical = isVertical;
    notifyListeners();
  }

  getBackgroundAsImage() => _backgroundAsImage;

  setBackgroundAsImage(bool backgroundAsImage) {
    _backgroundAsImage = backgroundAsImage;
    notifyListeners();
  }

  getBlurRadius() => _blurRadius;

  setBlurRadius(double blurRadius) {
    _blurRadius = blurRadius;
    notifyListeners();
  }

  getOpacity() => _opacity;

  setOpacity(double opacity) {
    _opacity = opacity;
    notifyListeners();
  }
}
