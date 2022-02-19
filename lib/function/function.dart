import 'package:flutter/cupertino.dart';

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
