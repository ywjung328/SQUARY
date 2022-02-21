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
    return RepaintBoundary(
      key: _globalKey,
      child: Hero(
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
            : Container(
                color: Colors.white,
                width: size,
                height: size,
                child: Stack(
                  children: [
                    Offstage(
                      offstage: !imageDataProvider.getBackgroundAsImage(),
                      child: SizedBox(
                        width: size,
                        height: size,
                        // child: ImageFiltered(
                        //   imageFilter:
                        //       ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        //   child: Image.memory(
                        //     imageDataProvider.getByteData(),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        child: ClipRect(
                          child: Offstage(
                            offstage: !imageDataProvider.getBackgroundAsImage(),
                            child: imageDataProvider.getBlurRadius() != 0.0
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX:
                                            imageDataProvider.getBlurRadius(),
                                        sigmaY:
                                            imageDataProvider.getBlurRadius()),
                                    child: SizedBox(
                                      width: size,
                                      height: size,
                                      child: Image.memory(
                                        imageDataProvider.getByteData(),
                                        fit: BoxFit.cover,
                                      ),
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
                    Container(
                      color: imageDataProvider
                          .getColor()
                          .withOpacity(imageDataProvider.getOpacity()),
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
