import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:image_picker/image_picker.dart';

enum ScreenType { DESKTOP, TABLET, MOBILE }

extension ParseToString on ScreenType {
  String asString() {
    return toString().split('.').last;
  }
}

ScreenType getScreenType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return width > 600
      ? (width > 1200 ? ScreenType.DESKTOP : ScreenType.TABLET)
      : ScreenType.MOBILE;
}

double getSpace(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return width > 600 ? (width > 1200 ? (width - 1200) / 2 + 72 : 48) : 32;
}

double getArea(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return width > 600 ? (width > 1200 ? 1056 : width - 96) : width - 64;
}

double getSquarySize(BuildContext context, double maxSize, double padding) {
  double width = MediaQuery.of(context).size.width;

  return width - padding * 2 > maxSize ? maxSize : width - padding * 2;
}

Route createRoute(BuildContext context, Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: 0.0, end: 1.0);
      final offsetAnimation = animation.drive(tween);
      return FadeTransition(opacity: offsetAnimation, child: child);
    },
  );
}

Future<Map> getImageData(XFile? image) async {
  Uint8List _byte = await image!.readAsBytes();
  var _decodedImage = await decodeImageFromList(_byte);
  String _name = image.name;
  bool _isVertical = _decodedImage.height > _decodedImage.width;

  Map result = {};
  result['byte'] = _byte;
  result['name'] = _name;
  result['isVertical'] = _isVertical;

  return result;
}

captureImage(GlobalKey captureKey, String name) async {
  RenderRepaintBoundary? renderObject =
      captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
  ui.Image capturedImage = await renderObject!.toImage(pixelRatio: 1800 / 400);
  ByteData? byteData =
      await capturedImage.toByteData(format: ui.ImageByteFormat.png);
  final rawData = byteData!.buffer.asUint8List();
  final content = base64Encode(rawData);
  final anchor = AnchorElement(
      href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    ..setAttribute("download", "SQUARY_$name.png")
    ..click();
}
