import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:provider/provider.dart';
// import 'package:nil/nil.dart';

class SquaryImage extends StatelessWidget {
  final double size;
  const SquaryImage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageDataProvider = Provider.of<ImageDataProvider>(context);
    return Hero(
      tag: "imageHeroTag",
      child: !imageDataProvider.getisPicked()
          ? Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.center,
                  child: imageDataProvider.getLoading()
                      ? const CupertinoActivityIndicator()
                      : Text(
                          "Tap here to open image!",
                          style: TextStyle(fontSize: size / 20),
                        ),
                ),
              ],
            )
          : ClipRect(
              child: Container(
                color: Colors.white,
                width: size,
                height: size,
                child: Stack(
                  children: [
                    Container(
                      color: imageDataProvider
                          .getColor()
                          .withOpacity(imageDataProvider.getOpacity()),
                    ),
                    Offstage(
                      offstage: !imageDataProvider.getBackgroundAsImage(),
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: Image.memory(
                          imageDataProvider.getByteData(),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !imageDataProvider.getBackgroundAsImage(),
                      child: imageDataProvider.getBlurRadius() == 0.0
                          ? Container(
                              color: imageDataProvider
                                  .getColor()
                                  .withOpacity(imageDataProvider.getOpacity()))
                          : BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: imageDataProvider.getBlurRadius(),
                                  sigmaY: imageDataProvider.getBlurRadius()),
                              child: Container(
                                color: imageDataProvider.getColor().withOpacity(
                                    imageDataProvider.getOpacity()),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.memory(
                        imageDataProvider.getByteData(),
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
