import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/function.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double space = getSpace(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: space),
                Text(
                  getScreenType(context).asString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getScreenType(context).asString(),
                  style: const TextStyle(color: Colors.black),
                ),
                SizedBox(width: space),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
