import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/squary_image.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../function/function.dart';
import '../provider/image_data_provider.dart';
import '../widget/bouncing_button.dart';

class SetBackgroundView extends StatelessWidget {
  const SetBackgroundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageDataProvider = Provider.of<ImageDataProvider>(context);
    double _size = getSquarySize(context, 500, 36);
    return Scaffold(
      // appBar: CustomAppBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "SQUARY",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSpace(context)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _size,
                  height: _size,
                  child: SquaryImage(size: _size),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        offset: const Offset(0.0, 15),
                        color: Colors.black.withOpacity(0.3),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text("Opacity"),
                Slider(
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: imageDataProvider.getOpacity().toString(),
                  value: imageDataProvider.getOpacity(),
                  onChanged: (value) => imageDataProvider.setOpacity(value),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Padding Color"),
                    const SizedBox(width: 15),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        onTap: () {
                          Color pickerColor = imageDataProvider.getColor();
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: imageDataProvider.setColor,
                                    enableAlpha: false,
                                    colorPickerWidth: 300,
                                    pickerAreaHeightPercent: 0.7,
                                    labelTypes: const [
                                      ColorLabelType.hsl,
                                      ColorLabelType.hsv
                                    ],
                                    displayThumbColor: true,
                                    paletteType: PaletteType.hsl,
                                    pickerAreaBorderRadius:
                                        const BorderRadius.only(
                                            topLeft: Radius.circular(2),
                                            topRight: Radius.circular(2)),
                                    hexInputBar: false,
                                    colorHistory:
                                        imageDataProvider.getColorHistory(),
                                    onHistoryChanged:
                                        imageDataProvider.addColorHistory,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: imageDataProvider
                                  .getColor()
                                  .withOpacity(imageDataProvider.getOpacity())),
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: imageDataProvider.getBackgroundAsImage(),
                      onChanged: (value) =>
                          imageDataProvider.setBackgroundAsImage(value!),
                    ),
                    const SizedBox(width: 4),
                    const Text("Use Image as Background"),
                  ],
                ),
                const SizedBox(height: 16),
                Offstage(
                  offstage: !imageDataProvider.getBackgroundAsImage(),
                  child: const Text("Blur Radius"),
                ),
                Offstage(
                  offstage: !imageDataProvider.getBackgroundAsImage(),
                  child: Slider(
                    min: 0,
                    max: 50,
                    divisions: 10,
                    label: imageDataProvider.getBlurRadius().round().toString(),
                    value: imageDataProvider.getBlurRadius(),
                    onChanged: (value) =>
                        imageDataProvider.setBlurRadius(value),
                  ),
                ),
                Hero(
                  tag: "buttonHeroTag",
                  child: BouncingButton(
                    radius: 100,
                    width: 72,
                    height: 72,
                    elevation: 30,
                    scale: 0.98,
                    child: const Center(
                      child: Icon(Icons.navigate_next_rounded),
                    ),
                    onPressed: () =>
                        createRoute(context, const SetBackgroundView()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
