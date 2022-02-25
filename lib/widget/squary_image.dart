import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:provider/provider.dart';
// import 'package:nil/nil.dart';

class SquaryImage extends StatelessWidget {
  final double size;
  SquaryImage({Key? key, required this.size}) : super(key: key);
  final GlobalKey _globalKey = GlobalKey();

  getGlobalKey() => _globalKey;

  @override
  Widget build(BuildContext context) {
    final imageDataProvider = Provider.of<ImageDataProvider>(context);
    print(size * (1 + imageDataProvider.getBlurRadius() / 100));
    print(
      1 / (1 + imageDataProvider.getBlurRadius() / 100),
    );
    return RepaintBoundary(
      key: _globalKey,
      child: Hero(
        tag: "imageHeroTag",
        child: !imageDataProvider.getisPicked()
            ? Center(
                child: Stack(
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
                ),
              )
            : Stack(
                children: [
                  Center(
                    child: Offstage(
                      offstage: !imageDataProvider.getBackgroundAsImage(),
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          widthFactor:
                              1 / (1 + imageDataProvider.getBlurRadius() / 100),
                          heightFactor:
                              1 / (1 + imageDataProvider.getBlurRadius() / 100),
                          child: SizedBox(
                            width: size *
                                (1 + imageDataProvider.getBlurRadius() / 100),
                            height: size *
                                (1 + imageDataProvider.getBlurRadius() / 100),
                            child: imageDataProvider.getBlurRadius() != 0.0
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX:
                                            imageDataProvider.getBlurRadius(),
                                        sigmaY:
                                            imageDataProvider.getBlurRadius()),
                                    child: Image.memory(
                                      imageDataProvider.getByteData(),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.memory(
                                    imageDataProvider.getByteData(),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: size,
                    height: size,
                    color: imageDataProvider
                        .getColor()
                        .withOpacity(imageDataProvider.getOpacity()),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: Image.memory(
                        imageDataProvider.getByteData(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
