import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/function.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:flutter_application_1/view/set_bg_view.dart';
import 'package:flutter_application_1/widget/squary_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widget/bouncing_button.dart';
//import 'package:flutter_application_1/widget/custom_app_bar.dart';

class OpenView extends StatelessWidget {
  const OpenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BouncingButton(
                radius: 0,
                width: _size,
                height: _size,
                elevation: 30,
                scale: 0.98,
                child: SquaryImage(size: _size),
                onPressed: () async {
                  // imageDataProvider.resetSourceImage();
                  XFile? _image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (_image == null) return;

                  imageDataProvider.resetSourceImage();

                  imageDataProvider.setPicked(false);
                  imageDataProvider.setLoading(true);

                  var _imageData = await compute(getImageData, _image);

                  imageDataProvider.setLoading(false);
                  imageDataProvider.setPicked(true);
                  imageDataProvider.setByteData(_imageData['byte']);
                  imageDataProvider.setName(_imageData['name']);
                  imageDataProvider.setIsVertical(_imageData['isVertical']);
                },
              ),
              const SizedBox(height: 36),
              imageDataProvider.getisPicked()
                  ? Hero(
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
                          onPressed: () => Navigator.of(context).push(
                              createRoute(context, const SetBackgroundView()))),
                    )
                  : const SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
