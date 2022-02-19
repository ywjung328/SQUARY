import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/function.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:flutter_application_1/widget/squary_image.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/bouncing_button.dart';
//import 'package:flutter_application_1/widget/custom_app_bar.dart';

class OpenView extends StatelessWidget {
  const OpenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    final ImageDataProvider _imageDataProvider = ImageDataProvider();
    return Scaffold(
      // appBar: CustomAppBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "SQUARY",
          style: TextStyle(
            fontSize: 32,
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
              const SquaryImage(size: 250),
              BouncingButton(
                radius: 0,
                width: 200,
                height: 100,
                child: const Text("PICK IMAGE"),
                onPressed: () async {
                  XFile? _image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  _imageDataProvider.setPicked(false);
                  _imageDataProvider.setLoading(true);

                  var _imageData = await compute(getImageData, _image);

                  _imageDataProvider.setLoading(false);
                  _imageDataProvider.setPicked(true);
                  _imageDataProvider.setByteData(_imageData['byte']);
                  _imageDataProvider.setName(_imageData['name']);
                  _imageDataProvider.setIsVertical(_imageData['isVertical']);
                },
                elevation: 30,
                scale: 0.98,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
