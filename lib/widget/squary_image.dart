import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:nil/nil.dart';

class SquaryImage extends StatelessWidget {
  final double size;
  const SquaryImage({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageDataProvider = Provider.of<ImageDataProvider>(context);
    return Hero(
      tag: "imageHeroTag",
      child: !imageDataProvider.getisPicked()
          ? Container(
              width: size,
              height: size,
              color: Colors.white,
            )
          : Container(
              color: imageDataProvider.getColor(),
              width: size,
              height: size,
              child: Stack(
                children: [
                  imageDataProvider.getBackgroundAsImage()
                      ? Image.memory(
                          imageDataProvider.getByteData(),
                          fit: BoxFit.cover,
                        )
                      : nil,
                  imageDataProvider.getBackgroundAsImage()
                      ? BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: imageDataProvider.getBlurRadius(),
                              sigmaY: imageDataProvider.getBlurRadius()),
                          child: Container(
                            color: imageDataProvider
                                .getColor()
                                .opacity(imageDataProvider.getOpacity()),
                          ),
                        )
                      : nil,
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
    );
  }
}
